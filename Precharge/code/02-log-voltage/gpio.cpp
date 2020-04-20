#include "gpio.h"

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


    // Animate status lights
    for (int i = 0; i < sizeof(STATUS_LED)/sizeof(*STATUS_LED); i++){
      digitalWrite(STATUS_LED[i], HIGH);
    }
    delay(500);
    for (int i = 0; i < sizeof(STATUS_LED)/sizeof(*STATUS_LED); i++){
      digitalWrite(STATUS_LED[i], LOW);
    }
    delay(500);

}
