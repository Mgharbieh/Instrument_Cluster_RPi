#include "canmanager.h"

/*
 * WHEN SETTING UP ON NEW DEVICE:
 *
 * apt-get install libqt6serialbus
 * apt-get install libqt6serialbus-dev
 *
 * apt-get install libqt6serialport
 * apt-get install libqt6serialport-dev
 *
 * apt-get install libsocketcan-dev
 *
 */

CANmanager::CANmanager()
{
    QString errorString;
    can_device = QCanBus::instance()->createDevice(QStringLiteral("socketcan"), QStringLiteral("can0"), &errorString);
    if (!can_device)
    {
        // Error handling goes here
        qDebug() << errorString;
    }
    else
    {
        can_device->connectDevice();
        qDebug() << "CAN Device connected!";
    }

    QCanBusDevice::Filter filter;
    QList<QCanBusDevice::Filter> filterList;


    filter.frameIdMask = 0xFFFu;
    filter.format = QCanBusDevice::Filter::MatchBaseFormat;
    filter.frameId = 0x64A;
    filterList.append(filter);

    filter.frameId = 0x649;
    filterList.append(filter);

    filter.frameId = 0x640;
    filterList.append(filter);

    filter.frameId = 0x641;
    filterList.append(filter);

    filter.frameId = 0x651;
    filterList.append(filter);

    can_device->setConfigurationParameter(QCanBusDevice::RawFilterKey, QVariant::fromValue(filterList));
    connect(can_device, &QCanBusDevice::framesReceived, this, &CANmanager::processFrames);
    connect(this, &CANmanager::signalLoop, this, &CANmanager::sendLoop);
    connect(&timer, &QTimer::timeout, this, &CANmanager::sendMessage); // need to test this

    initialTransmission = false;
    sendBuffer[2] = 0;
    frame.setFrameId(0x704);
}

//depreciated constructor overload
CANmanager::CANmanager(uint filterID)
{
    QString errorString;
    can_device = QCanBus::instance()->createDevice(QStringLiteral("socketcan"), QStringLiteral("can0"), &errorString);
    if (!can_device)
    {
        // Error handling goes here
        qDebug() << errorString;
    }
    else
    {
        can_device->connectDevice();
        qDebug() << "CAN Device connected!";
    }

    QCanBusDevice::Filter filter;
    QList<QCanBusDevice::Filter> filterList;
    filter.frameId = filterID;
    filter.frameIdMask = 0xFFFu;
    filter.format = QCanBusDevice::Filter::MatchBaseFormat;
    filterList.append(filter);

    can_device->setConfigurationParameter(QCanBusDevice::RawFilterKey, QVariant::fromValue(filterList));
    connect(can_device, &QCanBusDevice::framesReceived, this, &CANmanager::processFrames);
    connect(this, &CANmanager::signalLoop, this, &CANmanager::sendLoop);


    frame.setFrameId(0x704);
}

void CANmanager::processFrames()
{
    /*
    QCanBusFrame frame = can_device->readFrame();
    QByteArray bytes = frame.payload();
    //qDebug() << bytes;

    for(int i = 0; i < 8; i++)
        frameBuffer[i] = bytes.at(i);
    */

    QCanBusFrame frame = can_device->readFrame();
    QByteArray bytes = frame.payload();
    //qDebug() << bytes;

    qDebug() << frame.frameId();
    switch(frame.frameId())
    {
    case 0x640:
    {
        uint16_t inletManPres = (bytes.at(2)<< 8 | bytes.at(3)) * 100;
        uint16_t airTemp = (bytes.at(4)<< 8 | bytes.at(5)) / 10;
        setInletManifoldPres(inletManPres);
        setInletAirTemp(QString::number(airTemp) + "°C");
        break;
    }
    case 0x641:
    {
        uint16_t fuelPres = (bytes.at(4)<< 8 | bytes.at(5)) * 100;
        uint16_t fuelMix = (bytes.at(2)<< 8 | bytes.at(3)) / 100;
        setFuelPres(fuelPres);
        setFuelMixAim(fuelMix);
        break;
    }
    case 0x649:
    {
        setCoolantTemp(QString::number(bytes.at(0) - 40) + "°C");
        setOilTemp(QString::number(bytes.at(1) - 40) + "°C");
        setFuelTemp(QString::number(bytes.at(2) - 40) + "°C");
        break;
    }
    case 0x64A:
    {
        uint16_t exhaust = (bytes.at(0)<< 8 | bytes.at(1)) / 10;
        setExhaustTemp(QString::number(exhaust) + "°C");
        break;
    }
    case 0x64C:
    {
        uint8_t faultStatus = bytes.at(5);
        if(faultStatus > 0)
            setEcuFault(true);
        else
            setEcuFault(false);

        break;
    }
    case 0x651:
    {
        setExhaustLambda(bytes.at(0) / 100);
        break;
    }
    case 0x655:
    {
        uint16_t frontPressure = bytes.at(0)<< 8 | bytes.at(1);
        uint16_t rearPressure = bytes.at(2)<< 8 | bytes.at(3);
        setFrontBrakePres(frontPressure * 100);
        setRearBrakePres(rearPressure * 100);
        break;
    }
    case 0x659:
    {
        uint16_t speed = (bytes.at(4)<<8 | bytes.at(5)) / 36;
        setVehicleSpeed(speed * 2.2369); // convert from kph to mph
        break;
    }
    default:
    {
        break;
    }
    }

    emit(signalUI());
}

int* CANmanager::getFrame()
{
    return frameBuffer;
}

int CANmanager::getByte(int byte)
{
    return frameBuffer[byte];
}

void CANmanager::updatePayload(int id, int data)
{
    /*
    * ARRAY ID | VALUE
    * ---------|-------
    *   0      | BiasValue
    *   1      | TractionValue
    *   2      | Launch Flag (on/off)
    */
    sendBuffer[id] = data;
}

void CANmanager::sendMessage()
{
    if(can_device->busStatus() != QCanBusDevice::CanBusStatus::BusOff && can_device->busStatus() != QCanBusDevice::CanBusStatus::Error)
    {
        QByteArray sendBytes;
        for(int i = 0; i < 3; i++)
        {
            sendBytes.append(char(sendBuffer[i]));
        }

        //qDebug() << sendBytes;
        frame.setPayload(sendBytes);
        if(can_device->writeFrame(frame) && initialTransmission == false)
        {
            initialTransmission = true;
            emit(signalLoop());
        }
        else if(can_device->writeFrame(frame))
            timer.start(1000); //should work in theory, needs test
    }
}

bool CANmanager::sendOnce()
{
    if(can_device->busStatus() != QCanBusDevice::CanBusStatus::BusOff && can_device->busStatus() != QCanBusDevice::CanBusStatus::Error)
    {
        QByteArray sendBytes;
        for(int i = 0; i < 3; i++)
        {
            sendBytes.append(char(sendBuffer[i]));
        }

        //qDebug() << sendBytes;
        frame.setPayload(sendBytes);

        if(can_device->writeFrame(frame))
            return true;
        else
            return false;
    }
    else
        return false;
}

//wait to delete until verifying timer in sendMessage
void CANmanager::sendLoop()
{
    //Delay::delayMillis(1000);
    //sendMessage();

    timer.start(1000);
    sendMessage();
}

QCanBusDevice::CanBusStatus CANmanager::getDeviceStatus()
{
    return can_device->busStatus();
}

int CANmanager::rearBrakePres() const
{
    return m_rearBrakePres;
}

void CANmanager::setRearBrakePres(int newRearBrakePres)
{
    if (m_rearBrakePres == newRearBrakePres)
        return;
    m_rearBrakePres = newRearBrakePres;
    emit rearBrakePresChanged();
}

int CANmanager::frontBrakePres() const
{
    return m_frontBrakePres;
}

void CANmanager::setFrontBrakePres(int newFrontBrakePres)
{
    if (m_frontBrakePres == newFrontBrakePres)
        return;
    m_frontBrakePres = newFrontBrakePres;
    emit frontBrakePresChanged();
}

QString CANmanager::coolantTemp() const
{
    return m_coolantTemp;
}

void CANmanager::setCoolantTemp(QString newCoolantTemp)
{
    if (m_coolantTemp == newCoolantTemp)
        return;
    m_coolantTemp = newCoolantTemp;
    emit coolantTempChanged();
}

QString CANmanager::oilTemp() const
{
    return m_oilTemp;
}

void CANmanager::setOilTemp(QString newOilTemp)
{
    if (m_oilTemp == newOilTemp)
        return;
    m_oilTemp = newOilTemp;
    emit oilTempChanged();
}

QString CANmanager::fuelTemp() const
{
    return m_fuelTemp;
}

void CANmanager::setFuelTemp(QString newFuelTemp)
{
    if (m_fuelTemp == newFuelTemp)
        return;
    m_fuelTemp = newFuelTemp;
    emit fuelTempChanged();
}

int CANmanager::vehicleSpeed() const
{
    return m_vehicleSpeed;
}

void CANmanager::setVehicleSpeed(int newVehicleSpeed)
{
    if (m_vehicleSpeed == newVehicleSpeed)
        return;
    m_vehicleSpeed = newVehicleSpeed;
    emit vehicleSpeedChanged();
}

bool CANmanager::ecuFault() const
{
    return m_ecuFault;
}

void CANmanager::setEcuFault(bool newEcuFault)
{
    if (m_ecuFault == newEcuFault)
        return;
    m_ecuFault = newEcuFault;
    emit ecuFaultChanged();
}

QString CANmanager::exhaustTemp() const
{
    return m_exhaustTemp;
}

void CANmanager::setExhaustTemp(const QString &newExhaustTemp)
{
    if (m_exhaustTemp == newExhaustTemp)
        return;
    m_exhaustTemp = newExhaustTemp;
    emit exhaustTempChanged();
}

QString CANmanager::inletAirTemp() const
{
    return m_inletAirTemp;
}

void CANmanager::setInletAirTemp(const QString &newInletAirTemp)
{
    if (m_inletAirTemp == newInletAirTemp)
        return;
    m_inletAirTemp = newInletAirTemp;
    emit inletAirTempChanged();
}

int CANmanager::inletManifoldPres() const
{
    return m_inletManifoldPres;
}

void CANmanager::setInletManifoldPres(int newInletManifoldPres)
{
    if (m_inletManifoldPres == newInletManifoldPres)
        return;
    m_inletManifoldPres = newInletManifoldPres;
    emit inletManifoldPresChanged();
}

int CANmanager::fuelPres() const
{
    return m_fuelPres;
}

void CANmanager::setFuelPres(int newFuelPres)
{
    if (m_fuelPres == newFuelPres)
        return;
    m_fuelPres = newFuelPres;
    emit fuelPresChanged();
}

int CANmanager::fuelMixAim() const
{
    return m_fuelMixAim;
}

void CANmanager::setFuelMixAim(int newFuelMixAim)
{
    if (m_fuelMixAim == newFuelMixAim)
        return;
    m_fuelMixAim = newFuelMixAim;
    emit fuelMixAimChanged();
}

int CANmanager::exhaustLambda() const
{
    return m_exhaustLambda;
}

void CANmanager::setExhaustLambda(int newExhaustLambda)
{
    if (m_exhaustLambda == newExhaustLambda)
        return;
    m_exhaustLambda = newExhaustLambda;
    emit exhaustLambdaChanged();
}
