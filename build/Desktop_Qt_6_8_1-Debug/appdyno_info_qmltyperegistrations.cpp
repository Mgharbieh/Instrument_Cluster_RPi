/****************************************************************************
** Generated QML type registration code
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <QtQml/qqml.h>
#include <QtQml/qqmlmoduleregistration.h>

#if __has_include(<gpiohandler.h>)
#  include <gpiohandler.h>
#endif
#if __has_include(<jsonmanager.h>)
#  include <jsonmanager.h>
#endif


#if !defined(QT_STATIC)
#define Q_QMLTYPE_EXPORT Q_DECL_EXPORT
#else
#define Q_QMLTYPE_EXPORT
#endif
Q_QMLTYPE_EXPORT void qml_register_types_Dyno_Info()
{
    QT_WARNING_PUSH QT_WARNING_DISABLE_DEPRECATED
    qmlRegisterTypesAndRevisions<GPIOhandler>("Dyno_Info", 1);
    qmlRegisterTypesAndRevisions<JSONmanager>("Dyno_Info", 1);
    QT_WARNING_POP
    qmlRegisterModule("Dyno_Info", 1, 0);
}

static const QQmlModuleRegistration dynoInfoRegistration("Dyno_Info", qml_register_types_Dyno_Info);
