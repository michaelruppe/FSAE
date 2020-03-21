#include "gpio.h"


void setupGPIO(void) {
    // LEDs
    for (uint8_t i=0; i<(sizeof(STATUS_LED)/sizeof(*STATUS_LED)); i++) pinMode(STATUS_LED[i], OUTPUT);
    // Configuration solder-jumpers
    for (uint8_t i=0; i<(sizeof(CONFIG_PIN)/sizeof(*CONFIG_PIN)); i++) pinMode(CONFIG_PIN[i], INPUT);

    pinMode(SHUTDOWN_CTRL_PIN, OUTPUT);
    pinMode(PRECHARGE_CTRL_PIN, OUTPUT);
    pinMode(FREQ_TS_PIN, INPUT);
    pinMode(FREQ_ACCU_PIN, INPUT);
    pinMode(PDOC_PIN, INPUT);
    pinMode(PWR_OK_PIN, INPUT);

}

// Measure the frequency at a pin by measuring a pulse train.
// Do not assume 50% duty cycle, instead, measure a high pulse and a low pulse
// separately. This will combine measurements from two separate wavelengths, but
// that's fine with me.
unsigned long getFrequency(int pin) {
  unsigned long tHigh = pulseIn(pin,HIGH);
  unsigned long tLow = pulseIn(pin,LOW);
  return round(1000000.0/(tHigh + tLow));
}

unsigned int getVoltage(int pin) {
  unsigned long freq = getFrequency(pin);
  return (unsigned int)map(freq,0,10000,0,610); // TODO: use sensible values. SYSID
}
