#include "gpio.h"

const unsigned int TIMEOUT = 10000; // microseconds.
// 10,000 sets the lower frequncy limit to 100Hz or about 0.13V

void setupGPIO(void) {
    // LEDs
    for (uint8_t i=0; i<(sizeof(STATUS_LED)/sizeof(*STATUS_LED)); i++) pinMode(STATUS_LED[i], OUTPUT);
    // Configuration solder-jumpers
    for (uint8_t i=0; i<(sizeof(CONFIG_PIN)/sizeof(*CONFIG_PIN)); i++){
      pinMode(CONFIG_PIN[i], INPUT);
      digitalWrite(CONFIG_PIN[i], HIGH); // Activate pullup
    }

    pinMode(SHUTDOWN_CTRL_PIN, OUTPUT);
    digitalWrite(SHUTDOWN_CTRL_PIN, LOW);

    pinMode(PRECHARGE_CTRL_PIN, OUTPUT);
    digitalWrite(PRECHARGE_CTRL_PIN, LOW);

    pinMode(FREQ_TS_PIN, INPUT);
    pinMode(FREQ_ACCU_PIN, INPUT);
    pinMode(PDOC_PIN, INPUT);
    pinMode(PWR_OK_PIN, INPUT);

}

// Measure the frequency at a pin by measuring a pulse train.
// Do not assume 50% duty cycle, instead, measure a high pulse and a low pulse
// separately. This will combine measurements from two separate wavelengths, but
// that's fine with me.
double getFrequency(int pin) {
  unsigned long tHigh = pulseIn(pin, HIGH, TIMEOUT);
  unsigned long tLow = pulseIn(pin,LOW, TIMEOUT);
  return round(1/(1e-6 * (double)(tHigh + tLow)));
}

double getVoltage(int pin) {
  double freq = getFrequency(pin);
  return (double)map(freq,0,10000,0,610); // TODO: use sensible values. SYSID
}

double getPeriod(int pin) {
  unsigned long tHigh = pulseIn(pin, HIGH, TIMEOUT);
  unsigned long tLow = pulseIn(pin,LOW, TIMEOUT);
  return round(tHigh + tLow);
}
