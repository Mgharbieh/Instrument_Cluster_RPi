#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "jsonmanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    JSONmanager json;
    engine.rootContext()->setContextProperty("JSON", &json);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Dyno_Info", "Main");

    return app.exec();
}
