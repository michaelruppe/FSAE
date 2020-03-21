#include "gpio.h"
// CAN Libraries
// #include <circular_buffer.h>
// #include <FlexCAN_T4.h>
// #include <imxrt_flexcan.h>
// #include <kinetis_flexcan.h>

void setup() {
  Serial.begin(115200);
  // Initialise IO
  setupGPIO();


}

void loop() {
  Serial.print(getVoltage(FREQ_ACCU_PIN));
  Serial.print(getFrequency(FREQ_ACCU_PIN));

  delay(100);
}
