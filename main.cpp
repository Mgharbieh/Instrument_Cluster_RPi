#include <QGuiApplication>
#include <QQuickView>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "jsonmanager.h"
#include "canmanager.h"
#include "gpiohandler.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    JSONmanager json;
    CANmanager canBus;
    GPIOhandler gpio;

    engine.rootContext()->setContextProperty("JSON", &json);
    engine.rootContext()->setContextProperty("canBus", &canBus);
    engine.rootContext()->setContextProperty("gpio", &gpio);

    engine.loadFromModule("Dyno_Info", "Main");
    app.processEvents();
    app.processEvents();

    if(canBus.init())
    {
        canBus.updatePayload(CANmanager::FRONTBIAS, json.getBiasVal());
        canBus.updatePayload(CANmanager::TCSWITCH, json.getTractionSwitch() * 3);
        canBus.updatePayload(CANmanager::ANTI_LAG, json.antiLag() * 3);
        canBus.updatePayload(CANmanager::FUEL_AIM, json.fuelAim());
        canBus.updatePayload(CANmanager::IGNITION, json.ignitionTiming());
        canBus.updatePayload(CANmanager::LAUNCH_AIM, json.launchAim() * 3);
        canBus.updatePayload(CANmanager::THROTTLE_MAP, json.throttleMap());
        canBus.sendLoop();
        emit canBus.initialized();
    }

    qDebug() << qVersion();

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    return app.exec();
}
