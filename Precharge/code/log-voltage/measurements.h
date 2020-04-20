#ifndef MEAS_H
#define MEAS_H
#include "Arduino.h"
#include "gpio.h"

double getTsVoltage();
double getAccuVoltage();
double getFrequency(int pin);
double getVoltage(int pin);
double getPeriod(int pin);
bool isInBounds(double f);

#endif
