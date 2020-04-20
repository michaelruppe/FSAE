// Run a precharge cycle and log the voltages to console for plotting

#include "gpio.h"
#include "measurements.h"
// CAN Libraries
// #include <circular_buffer.h>
// #include <FlexCAN_T4.h>
// #include <imxrt_flexcan.h>
// #include <kinetis_flexcan.h>


unsigned long startTime;


void setup() {
  Serial.begin(460800);
  // Initialise IO
  setupGPIO();
  delay(3000);
  startTime = millis() + 1500;
  Serial.println("Time(ms),Vaccu,Vts");

}


void loop() {

  unsigned long now = millis();
  const unsigned long durationCharge = 6000;   // duration to precharge
  const unsigned long durationExperiment = 25000;   // total experiment duration


  // precharge contactor switching
  if (now < startTime || now > startTime + durationCharge) {
    digitalWrite(PRECHARGE_CTRL_PIN, LOW);
  } else {
    digitalWrite(PRECHARGE_CTRL_PIN, HIGH);
  }

  if (now < startTime + durationExperiment) {

    // double fAccu = getFrequency(FREQ_ACCU_PIN);
    // double fTs = getFrequency(FREQ_TS_PIN);

    double vAccu = getAccuVoltage();
    double vTs = getTsVoltage();

    Serial.print((long)now - (long)startTime);
    Serial.print(",");
    // Serial.print(fAccu);
    // Serial.print(",");
    // Serial.print(fTs);
    // Serial.print(",");
    Serial.print(vAccu);
    Serial.print(",");
    Serial.print(vTs);

    Serial.println();
  }

}
