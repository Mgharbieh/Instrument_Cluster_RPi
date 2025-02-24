#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QUrl>

#include "gpiohandler.h"
#include "jsonmanager.h"
#include "canmanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    JSONmanager json;

    CANmanager canBus;

    GPIOhandler gpioHandler;

    engine.rootContext()->setContextProperty("gpioHandler", &gpioHandler);
    engine.load(QStringLiteral("qrc:/Main.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;

    canBus.updatePayload(CANmanager::FRONTBIAS, json.getBiasVal());
    canBus.updatePayload(CANmanager::TCSWITCH, json.getTractionSwitch());
    canBus.sendOnce();

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
