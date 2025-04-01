#include "gpiohandler.h"

#define BUTTON_TOP 23
#define BUTTON_BOTTOM 24
#define BUTTON_LEFT 27
#define BUTTON_RIGHT 22

#define PRESS_DELAY 100 //millis
#define HOLD_DELAY 250 //millis

#define SHUTDOWN_PIN NULL //add later

GPIOhandler* GPIOhandler::InterruptPtr;

GPIOhandler::GPIOhandler(QObject *parent)
    : QObject{parent}
{
    InterruptPtr = this;
    if(QSysInfo::productType() != "pop")
    {
        if(wiringPiSetupGpio() == -1)
            qDebug() << "GPIO init failed...";
        else
        {
            pinMode(BUTTON_RIGHT, INPUT);
            pinMode(BUTTON_LEFT, INPUT);
            pinMode(BUTTON_TOP, INPUT);
            pinMode(BUTTON_BOTTOM, INPUT);
            pullUpDnControl(BUTTON_RIGHT, PUD_UP);
            pullUpDnControl(BUTTON_LEFT, PUD_UP);
            pullUpDnControl(BUTTON_TOP, PUD_UP);
            pullUpDnControl(BUTTON_BOTTOM, PUD_UP);

            wiringPiISR(BUTTON_RIGHT, INT_EDGE_FALLING, &pushButtonRight);
            wiringPiISR(BUTTON_LEFT, INT_EDGE_FALLING, &pushButtonLeft);
            wiringPiISR(BUTTON_TOP, INT_EDGE_FALLING, &pushButtonTop);
            wiringPiISR(BUTTON_BOTTOM, INT_EDGE_FALLING, &pushButtonBottom);
        }
    }
}

GPIOhandler::~GPIOhandler() {
    delete InterruptPtr;
}


void GPIOhandler::pushButtonRight()
{
    delay(PRESS_DELAY);  //Debounce
    if(digitalRead(BUTTON_RIGHT) == LOW)
    {
        emit InterruptPtr->buttonRight();

        delay(HOLD_DELAY);
        while(digitalRead(BUTTON_RIGHT) == LOW)
        {
            emit InterruptPtr->buttonRight();
            delay(PRESS_DELAY);
        }
    }
}

void GPIOhandler::pushButtonLeft()
{
    delay(PRESS_DELAY);  //Debounce
    if(digitalRead(BUTTON_LEFT) == LOW)
    {
        emit InterruptPtr->buttonLeft();

        delay(HOLD_DELAY);
        while(digitalRead(BUTTON_LEFT) == LOW)
        {
            emit InterruptPtr->buttonLeft();
            delay(PRESS_DELAY);
        }
    }
}

void GPIOhandler::pushButtonTop()
{
    delay(PRESS_DELAY);  //Debounce
    if(digitalRead(BUTTON_TOP) == LOW)
    {
        emit InterruptPtr->buttonTop();

        delay(HOLD_DELAY);
        while(digitalRead(BUTTON_TOP) == LOW)
        {
            emit InterruptPtr->buttonTop();
            delay(PRESS_DELAY);
        }
    }
}

void GPIOhandler::pushButtonBottom()
{
    delay(PRESS_DELAY);  //Debounce
    if(digitalRead(BUTTON_BOTTOM) == LOW)
    {
        emit InterruptPtr->buttonBottom();

        delay(HOLD_DELAY);
        while(digitalRead(BUTTON_BOTTOM) == LOW)
        {
            emit InterruptPtr->buttonBottom();
            delay(PRESS_DELAY);
        }
    }
}
