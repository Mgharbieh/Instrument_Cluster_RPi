#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QUrl>

#include "jsonmanager.h"
#include "canmanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    JSONmanager json;
    CANmanager canBus;

    canBus.updatePayload(CANmanager::FRONTBIAS, json.getBiasVal());
    canBus.updatePayload(CANmanager::TCSWITCH, json.getTractionSwitch());
    canBus.updatePayload(CANmanager::ANTI_LAG, json.antiLag());
    canBus.updatePayload(CANmanager::FUEL_AIM, json.fuelAim());
    canBus.updatePayload(CANmanager::IGNITION, json.ignitionTiming());
    canBus.updatePayload(CANmanager::LAUNCH_AIM, json.launchAim());
    canBus.updatePayload(CANmanager::THROTTLE_MAP, json.throttleMap());
    //canBus.sendLoop();

    engine.rootContext()->setContextProperty("JSON", &json);
    engine.rootContext()->setContextProperty("canBus", &canBus);

    qDebug() << qVersion();

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Dyno_Info", "Main");

    return app.exec();
}
