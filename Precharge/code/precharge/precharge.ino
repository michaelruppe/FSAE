// Run a precharge cycle and log the voltages to console for plotting

#include "gpio.h"
#include "measurements.h"
#include "moving-average.h"
#include "states.h"

// Exponential Moving Average Filters
MovingAverage TSV_Average(0, 0.1); // Tractive system Voltage
MovingAverage ACV_Average(0, 0.1); // Accumulator (upstream of precharge resistor)
MovingAverage SDC_Average(0, 0.3); // Shutdown Circuit

STATEVAR state = STATE_STANDBY;
STATEVAR lastState = STATE_UNDEFINED;

unsigned long now;

void setup() {
  Serial.begin(460800);
  // Initialise IO
  setupGPIO();
  delay(3000);


}


void loop() {
  now = millis();
  SDC_Average.update(getShutdownCircuitVoltage());

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


    default :
      state = STATE_STANDBY;
      standby();


  }

}

// Open AIRs, Open Precharge, indicate status, wait for stable shutdown circuit
void standby() {
  static unsigned long epoch = millis();
  if (lastState != STATE_STANDBY) {
    Serial.println(" === STANDBY");
    epoch = millis(); // make sure to reset if we've circled back to standby
    Serial.println("* Waiting for stable shutdown circuit");
    lastState = STATE_STANDBY;
  }
  digitalWrite(PRECHARGE_CTRL_PIN, LOW);
  digitalWrite(SHUTDOWN_CTRL_PIN, LOW);

  // Check for stable shutdown circuit
  const float MIN_SDC_VOLTAGE = 11.0;
  const unsigned int WAIT_TIME = 200; // ms to wait for stable voltage
  if (SDC_Average.value() >= MIN_SDC_VOLTAGE){
    if (millis() > epoch + WAIT_TIME){
      state = STATE_PRECHARGE;
    }
  } else {
    epoch = millis(); // reset timer
  }

}

void precharge() {
  // TODO: Look for "too fast" precharge, indicates wiring fault

  const float PRECHARGE_PERCENT = 0.87;
  const unsigned int SETTLING_TIME = 300; // ms
  static unsigned long epoch = millis();
  if (lastState != STATE_PRECHARGE){
    Serial.println(" === PRECHARGE");
    lastState = STATE_PRECHARGE;
  }


  digitalWrite(PRECHARGE_CTRL_PIN, HIGH);

  // Look for steady accumulator voltage, set as a reference for precharge

  ACV_Average.update(getAccuVoltage());
  TSV_Average.update(getTsVoltage());
  double acv = ACV_Average.value();
  double tsv = TSV_Average.value();
  double prechargeProgress = tsv / acv;
  /*if (now % 500 == 0)*/ Serial.println(prechargeProgress);
  if ( prechargeProgress >= PRECHARGE_PERCENT ) { // Precharge complete
    if (now > epoch + SETTLING_TIME){
      state = STATE_RUN;
    }
  } else {
    epoch = now;
  }



}

void running() {
  if (lastState != STATE_RUN){
    Serial.println(" === RUNNING");
    lastState = STATE_RUN;
  }

  // TODO: Asynchronous control of relays. Don't use delays
  digitalWrite(SHUTDOWN_CTRL_PIN, HIGH);
  digitalWrite(PRECHARGE_CTRL_PIN, LOW);

}
