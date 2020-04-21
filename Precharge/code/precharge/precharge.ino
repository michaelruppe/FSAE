/*
  Precharge - Code to drive the Precharge prototype module
  Created by Michael Ruppe, April, 2020.
  For more documentation, visit:
  https://github.com/michaelruppe/FSAE

  Perform a find (Ctrl+f) for "TODO" to see if I left you any surprises :D

  Features:
    - Voltage feedback ensures sufficient precharge before closing AIR
    - Wiring fault / stuck-discharge detection on "too fast" precharge
    - Arrests AIR chatter -> minimum precharge time triggers error state and
      requires uC reset or power cycle.
*/


#include "gpio.h"
#include "measurements.h"
#include "moving-average.h"
#include "states.h"

const float MIN_SDC_VOLTAGE = 11.0; // [Volts]

// Exponential Moving Average Filters
MovingAverage TSV_Average(0, 0.1); // Tractive system Voltage
MovingAverage ACV_Average(0, 0.1); // Accumulator (upstream of precharge resistor)
MovingAverage SDC_Average(0, 0.3); // Shutdown Circuit

STATEVAR state = STATE_STANDBY;
STATEVAR lastState = STATE_UNDEFINED;
int errorCode = ERR_NONE;

StatusLight statusLED[4] {{ STATUS_LED[0] },
                          { STATUS_LED[1] },
                          { STATUS_LED[2] },
                          { STATUS_LED[3] }};

unsigned long now; // Uptime from millis()

void setup() {
  Serial.begin(460800);
  setupGPIO();
  delay(3000);

}


void loop() {
  now = millis();

  // Always monitor Shutdown Circuit Voltage and react
  // Error state should be deadlocked - no way out.
  SDC_Average.update(getShutdownCircuitVoltage());
  if ( SDC_Average.value() < MIN_SDC_VOLTAGE && state != STATE_ERROR) {
    state = STATE_STANDBY;
  }

  // The State Machine
  switch(state){
    case STATE_STANDBY :
      standby();
      break;

    case STATE_PRECHARGE :
      precharge();
      break;

    case STATE_RUN :
      running();
      break;


    case STATE_ERROR :
      errorState();

    default : // You tried to enter a state not defined in this switch-case
      state = STATE_ERROR;
      errorCode |= ERR_STATE_UNDEFINED;
      errorState();
  }

  updateStatusLeds();

}

// Open AIRs, Open Precharge, indicate status, wait for stable shutdown circuit
void standby() {
  static unsigned long epoch = millis();
  if (lastState != STATE_STANDBY) {
    updateStatusLeds(0,0);
    statusLED[0].on();
    Serial.println(F(" === STANDBY"));
    epoch = millis(); // make sure to reset if we've circled back to standby
    Serial.println(F("* Waiting for stable shutdown circuit"));
    lastState = STATE_STANDBY;
  }
  digitalWrite(PRECHARGE_CTRL_PIN, LOW);
  digitalWrite(SHUTDOWN_CTRL_PIN, LOW);

  // Check for stable shutdown circuit
  const unsigned int WAIT_TIME = 200; // ms to wait for stable voltage
  if (SDC_Average.value() >= MIN_SDC_VOLTAGE){
    if (millis() > epoch + WAIT_TIME){
      state = STATE_PRECHARGE;
    }
  } else {
    epoch = millis(); // reset timer
  }

}

// Close the precharge relay, monitor precharge voltage.
// Trip error if charge-time looks unusual
void precharge() {
  // Look for "too fast" or "too slow" precharge, indicates wiring fault
  const float MIN_EXPECTED = 500; // [ms].
  const float MAX_EXPECTED = 5000; // [ms].
  // If a precharge is detected faster than this, an error is
  // thrown - assumed wiring fault. This will also arrest oscillating or
  // chattering AIRs, because the TS will retain some amount of precharge.
  const float PRECHARGE_PERCENT = 88.0;   // TODO: Change to suitable value during commissioning
  const unsigned int SETTLING_TIME = 300; // [ms]
  static unsigned long epoch;
  static unsigned long tStartPre;

  if (lastState != STATE_PRECHARGE){
    updateStatusLeds(0,0);
    statusLED[1].on();
    Serial.println(F(" === PRECHARGE"));
    lastState = STATE_PRECHARGE;
    epoch = now;
    tStartPre = now;
  }


  digitalWrite(PRECHARGE_CTRL_PIN, HIGH);

  // Look for steady accumulator voltage, set as a reference for precharge
  static unsigned long lastSample = 0;
  const unsigned long samplePeriod = 10; // [ms] Period to measure voltages
  if (now > lastSample + samplePeriod){
    lastSample = now;
    ACV_Average.update(getAccuVoltage());
    TSV_Average.update(getTsVoltage());
  }
  double acv = ACV_Average.value();
  double tsv = TSV_Average.value();
  double prechargeProgress = 100.0 * tsv / acv;
  static unsigned long lastPrint = 0;

  // Print Precharging progress
  if (now >= lastPrint + 100) {
    lastPrint = now;
    char str[80]; // output buffer
    // This looks like: 100ms 21.96% 44.5V
    // TODO: fix format string - not aligning float aesthetically, not printing "%"
    sprintf(str, "%5ums %4.2f \% 5.1fV", now-tStartPre, prechargeProgress, TSV_Average.value());
    Serial.println(str);
  }

  // Check if precharge complete
  if ( prechargeProgress >= PRECHARGE_PERCENT ) {
    // Precharge complete
    if (now > epoch + SETTLING_TIME){
      state = STATE_RUN;
      Serial.print(F("* Precharge complete at: "));
      Serial.print(prechargeProgress);
      Serial.print(F("%  "));
      Serial.print(TSV_Average.value());
      Serial.print(F("Volts\n"));
    }
    else if (now < tStartPre + MIN_EXPECTED) {    // Precharge too fast - something's wrong!
      state = STATE_ERROR;
      errorCode |= ERR_PRECHARGE_TOO_FAST;
    }

  } else {
    // Precharging
    epoch = now;

    if (now > tStartPre + MAX_EXPECTED) {       // Precharge too slow - something's wrong!
      state = STATE_ERROR;
      errorCode |= ERR_PRECHARGE_TOO_SLOW;
    }
  }



}

void running() {
  const unsigned int T_OVERLAP = 500; // ms. Time to overlap the switching of AIR and Precharge
  static unsigned long epoch;
  if (lastState != STATE_RUN){
    updateStatusLeds(0,0);
    statusLED[2].on();
    Serial.println(F(" === RUNNING"));
    lastState = STATE_RUN;
    epoch = now;
  }

  digitalWrite(SHUTDOWN_CTRL_PIN, HIGH);
  if (now > epoch + T_OVERLAP) digitalWrite(PRECHARGE_CTRL_PIN, LOW);

}

void errorState() {
  digitalWrite(PRECHARGE_CTRL_PIN, LOW);
  digitalWrite(SHUTDOWN_CTRL_PIN, LOW);

  if (lastState != STATE_ERROR){
    lastState = STATE_ERROR;
    updateStatusLeds(0,0);      // All off
    statusLED[3].update(50,50); // Strobe STS LED
    Serial.println(F(" === ERROR"));

    // Display errors: Serial and Status LEDs
    if (errorCode == ERR_NONE){
      Serial.println(F("   *Error state, but no error code logged..."));
    }
    if (errorCode & ERR_PRECHARGE_TOO_FAST) {
      Serial.println(F("   *Precharge too fast. Suspect wiring fault / chatter in shutdown circuit."));
      statusLED[0].on();
    }
    if (errorCode & ERR_PRECHARGE_TOO_SLOW) {
      Serial.println(F("   *Precharge too slow. Suspect wiring fault."));
      statusLED[0].update(100,100);
    }
    if (errorCode & ERR_STATE_UNDEFINED) {
      Serial.println(F("   *State not defined in The State Machine."));
    }
  }

}


// Loop through the array and call update.
void updateStatusLeds() {
  for (uint8_t i=0; i<(sizeof(statusLED)/sizeof(*statusLED)); i++){
    statusLED[i].update();
  }
}
void updateStatusLeds(long ton, long toff) {
  for (uint8_t i=0; i<(sizeof(statusLED)/sizeof(*statusLED)); i++){
    statusLED[i].update(ton, toff);
  }
}
