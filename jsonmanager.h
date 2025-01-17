#ifndef JSONMANAGER_H
#define JSONMANAGER_H

#include <QObject>
#include <QCoreApplication>
#include <QtQml>

#include <QFile>
#include <QByteArray>

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonParseError>

#include <vector>
#include <mapVals.h>


class JSONmanager : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(int driver READ getDriver WRITE setDriver NOTIFY DriverChanged FINAL)
    Q_PROPERTY(int biasVal READ getBiasVal WRITE setBiasVal NOTIFY BiasValChanged FINAL)
    Q_PROPERTY(int tractionSwitch READ getTractionSwitch WRITE setTractionSwitch NOTIFY tractionSwitchChanged FINAL)

public:
    JSONmanager();

    void loadProfileOnBoot();
    Q_INVOKABLE void loadProfile(int);

    bool updateBrakeBias(int, int);
    bool updateTractionCtl(int, int);

    bool loadChannelList(std::vector<mapVals>&);
    //bool setWidgetChannel(int, QString);

    int getBiasVal() const;
    void setBiasVal(int newBiasVal);

    int getDriver() const;
    void setDriver(int newDriver);

    int getTractionSwitch() const;
    void setTractionSwitch(int newTractionSwitch);

signals:
    void BiasValChanged();

    void DriverChanged();

    void tractionSwitchChanged();

private:

    QFile file;

    QJsonDocument jsonDoc;
    QJsonObject jsonObj;
    QJsonArray jsonArray;
    QJsonParseError jsonParse;

    int m_driver;
    int m_biasVal;
    int m_tractionSwitch;
};

#endif // JSONMANAGER_H
