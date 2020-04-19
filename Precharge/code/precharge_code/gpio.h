// Pin definitions for the project

#ifndef PINDEFS_H
#define PINDEFS_H
#include "Arduino.h"
#include <stdint.h>

// Configuration solder-jumpers
const int CONFIG_PIN[] = {4,5,6};
// Status LEDs
const int STATUS_LED[] = {0,1,2,3};

// Relays
const int SHUTDOWN_CTRL_PIN = 11;
const int PRECHARGE_CTRL_PIN = 12;

// Frequency measurements (from Voltage-to-Frequency converters)
const int FREQ_ACCU_PIN = 14;
const int FREQ_TS_PIN = 15;

// Status inputs
const int PDOC_PIN = A7; // Active-high when PDOC is OK
const int PWR_OK_PIN = A4; // Active-high when power-supply (shutdown circuit) is OK

// Function prototypes
void setupGPIO(void);

#endif
