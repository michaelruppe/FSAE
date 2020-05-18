/*
  Precharge - Code to drive the NU Racing Precharge module (prototype)
  Created by Michael Ruppe
  April 2020

  Watch a primer video on this device here: https://youtu.be/6-RndXZ5mR4
  For more documentation, visit: https://github.com/michaelruppe/FSAE

  Dear future FSAE engineer,
  Perform a find (Ctrl+f) for "TODO" to see if I left you any surprises :D

  Commissioning notes:
    - Make sure TARGET_PERCENT is sensible (95%). I set it much lower
      during prototyping.

  Features:
    - Voltage feedback ensures sufficient precharge before closing AIR
    - Wiring fault / stuck-discharge detection on "too-fast/slow" precharge
    - May arrest AIR chatter -> minimum precharge time triggers error state and
      requires uC reset or power cycle.


  Other Notes:
    - Consider adding a condition to the STATE_STANDBY -> STATE_PRECHARGE
      transition: Check for near-zero TS voltages ensures full discharge before
      attempting a precharge.
*/


#include "gpio.h"
#include "measurements.h"
#include "moving-average.h"
#include "states.h"

const float MIN_SDC_VOLTAGE = 11.0; // [Volts]

// Exponential Moving Average Filters
MovingAverage TSV_Average(0, 0.1); // Tractive system Voltage
MovingAverage ACV_Average(0, 0.1); // Accumulator (upstream of precharge resistor)
MovingAverage SDC_Average(0, 0.5); // Shutdown Circuit

STATEVAR state = STATE_STANDBY;
STATEVAR lastState = STATE_UNDEFINED;
int errorCode = ERR_NONE;

StatusLight statusLED[4] {{ STATUS_LED[0] },
                          { STATUS_LED[1] },
                          { STATUS_LED[2] },
                          { STATUS_LED[3] }};

char lineBuffer[50];
unsigned long now; // Uptime from millis()

void setup() {
  Serial.begin(460800);
  setupGPIO();
  delay(3000);  // TODO: remove during commissioning

}


void loop() {
  now = millis();

  // Always monitor Shutdown Circuit Voltage and react
  monitorShutdownCircuit();

  // The State Machine
  switch(state){
    case STATE_STANDBY :
      standby();
      break;

    case STATE_PRECHARGE :
      precharge();
      break;

    case STATE_ONLINE :
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

void monitorShutdownCircuit() {
  static unsigned long lastSample = 0;
  if (now > lastSample + 10) {
    lastSample = now;
    SDC_Average.update(getShutdownCircuitVoltage());
  }
  // Error state should be deadlocked - no way out.
  if ( SDC_Average.value() < MIN_SDC_VOLTAGE && state != STATE_ERROR) {
    state = STATE_STANDBY;
  }
}

// Open AIRs, Open Precharge, indicate status, wait for stable shutdown circuit
void standby() {
  static unsigned long epoch;
  if (lastState != STATE_STANDBY) {
    lastState = STATE_STANDBY;
    statusLEDsOff();
    statusLED[0].on();
    Serial.println(F(" === STANDBY"));
    Serial.println(F("* Waiting for stable shutdown circuit"));
    epoch = millis(); // make sure to reset if we've circled back to standby

    // Reset moving averages
    TSV_Average.reset();
    ACV_Average.reset();
    SDC_Average.reset();
  }

  // Disable AIR, Disable Precharge
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
  const float MIN_EXPECTED = 500; // [ms]. Set this to something reasonable after collecting normal precharge sequence data
  const float MAX_EXPECTED = 3000; // [ms]. Set this to something reasonable after collecting normal precharge sequence data
  // If a precharge is detected faster than this, an error is
  // thrown - assumed wiring fault. This could also arrest oscillating or
  // chattering AIRs, because the TS will retain some amount of precharge.
  const float TARGET_PERCENT = 88.0;   // TODO: Requires suitable value during commissioning (eg 95%)
  const unsigned int SETTLING_TIME = 200; // [ms] Precharge amount must be over TARGET_PERCENT for this long before we consider precharge complete
  static unsigned long epoch;
  static unsigned long tStartPre;

  if (lastState != STATE_PRECHARGE){
    digitalWrite(PRECHARGE_CTRL_PIN, HIGH);
    lastState = STATE_PRECHARGE;
    statusLEDsOff();
    statusLED[1].on();
    sprintf(lineBuffer, " === PRECHARGE   Target precharge %4.1f%%\n", TARGET_PERCENT);
    Serial.print(lineBuffer);
    epoch = now;
    tStartPre = now;
  }

  // Sample the voltages and update moving averages
  const unsigned long samplePeriod = 10; // [ms] Period to measure voltages
  static unsigned long lastSample = 0;
  if (now > lastSample + samplePeriod){  // samplePeriod and movingAverage alpha value will affect moving average response.
    lastSample = now;
    ACV_Average.update(getAccuVoltage());
    TSV_Average.update(getTsVoltage());
  }
  double acv = ACV_Average.value();
  double tsv = TSV_Average.value();

  // The precharge progress is a function of the accumulator voltage
  double prechargeProgress = 100.0 * tsv / acv; // [%]

  // Print Precharging progress
  static unsigned long lastPrint = 0;
  if (now >= lastPrint + 100) {
    lastPrint = now;
    sprintf(lineBuffer, "%5lums %4.1f%%   %5.1fV\n", now-tStartPre, prechargeProgress, TSV_Average.value());
    Serial.print(lineBuffer);
  }

  // Check if precharge complete
  if ( prechargeProgress >= TARGET_PERCENT ) {
    // Precharge complete
    if (now > epoch + SETTLING_TIME){
      state = STATE_ONLINE;
      sprintf(lineBuffer, "* Precharge complete at: %2.0f%%   %5.1fV\n", prechargeProgress, TSV_Average.value());
      Serial.print(lineBuffer);
    }
    else if (now < tStartPre + MIN_EXPECTED && now > epoch + SETTLING_TIME) {    // Precharge too fast - something's wrong!
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
  if (lastState != STATE_ONLINE){
    statusLEDsOff();
    statusLED[2].on();
    Serial.println(F(" === RUNNING"));
    lastState = STATE_ONLINE;
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
    statusLEDsOff();
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
      Serial.println(F("   *Precharge too slow. Potential causes:\n   - Wiring fault\n   - Discharge is stuck-on\n   - Target precharge percent is too high"));
      statusLED[1].on();
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
void statusLEDsOff() {
  for (uint8_t i=0; i<(sizeof(statusLED)/sizeof(*statusLED)); i++){
    statusLED[i].off();
  }
}
void updateStatusLeds(long ton, long toff) {
  for (uint8_t i=0; i<(sizeof(statusLED)/sizeof(*statusLED)); i++){
    statusLED[i].update(ton, toff);
  }
}
