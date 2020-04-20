/*
  V-F Experiment
  This program simply logs the frequencies measured from the
  V-F converters.
  Use this program to measure their V-F responses


  Michael Ruppe Apr 2020
*/

#include "gpio.h"

unsigned long startTime;

void setup() {
  Serial.begin(115200);

  Serial.print("F_CPU_ACTUAL=");
  Serial.println(F_CPU_ACTUAL);

  // Initialise IO
  setupGPIO();

  // Startup animation
  for (int i = 0; i < sizeof(STATUS_LED)/sizeof(*STATUS_LED); i++){
    digitalWrite(STATUS_LED[i], HIGH);
    delay(500);
  }
  for (int i = 0; i < sizeof(STATUS_LED)/sizeof(*STATUS_LED); i++){
    digitalWrite(STATUS_LED[i], LOW);
  }

}

void loop() {

  int num_samples = 20; // Take the average of many samples

  // ACCUMULATOR VOLTAGE-FREQUENCY
  double sum = 0;
  for (int i = 0; i < num_samples; i++) {
    sum += getFrequency(FREQ_ACCU_PIN);
  }
  Serial.print(sum/(double)num_samples);
  Serial.print(",");

  // TRACTIVE SYSTEM VOLTAGE-FREQUENCY
  sum = 0;
  for (int i = 0; i < num_samples; i++) {
    sum += getFrequency(FREQ_TS_PIN);
  }
  Serial.print(sum/(double)num_samples);
  Serial.println();
  delay(1000);
}
