#include "gpio.h"
// CAN Libraries
// #include <circular_buffer.h>
// #include <FlexCAN_T4.h>
// #include <imxrt_flexcan.h>
// #include <kinetis_flexcan.h>

enum STATE {
  START,
  PRECHARGE,
  ONLINE,
  SHUTDOWN,
  ERROR,
  DEBUG_STATE
} state = DEBUG_STATE;

enum MODE {
  VOLTAGE_95  = 0b00000000,
  TIMER_3     = 0b00000001,
  TIMER_5     = 0b00000010,
  TIMER_8     = 0b00000011,
  DEBUG_MODE  = 0b00000111
} mode = VOLTAGE_95;

enum ERR_CODE {
  NONE,
  V_SUPP_LOW,
  TIMEOUT
} errCode = NONE;

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


void start() {
  // read config from solder jumpers and set the mode:
  // read the pin state and shift it into the correct position.
  // Soldered = LOW / Unsoldered = HIGH (Pullups)
  for (int i = 0; i < sizeof(CONFIG_PIN)/sizeof(*CONFIG_PIN); i++){
    mode |= !digitalRead(CONFIG_PIN[i]) << i;
  }

  // Make sure shutdown circuit is stable enough before proceeding.
  // check for low-voltage
  unsigned int pwrADC = analogRead(PWR_OK_PIN);
  const float R1 = 20; //kOhms measurement voltage divider
  const float R2 = 7;  //kOhms
  const float DIODE_VF = 0.7; //Volts: diode forward voltage
  const int ADC_MAX = 4095;
  const float V_ADC_MAX = 3.3;
  float pwrVolts = map((float)pwrADC, 0, ADC_MAX, 0, V_ADC_MAX); //map ADC to 3.3V
  pwrVolts /= (R2)/(R1+R2) + DIODE_VF; // scale by voltage divider, include diode Vf

  // Passed checks, proceed
  if (pwrVolts >= 11.2 || mode != DEBUG_MODE){
    state = PRECHARGE;
  } else {
    state = ERROR;
    errCode = V_SUPP_LOW;
  }
}

void precharge() {
  // activate precharge relay

  // look for charging slope. Reject instant precharge (implies open circuit)

  // close AIR

}

void online() {

  // open precharge relay
}

void shutdown() {
  // open AIR, precharge
  // delay
  state = START;
}
