#include "gpio.h"
#include "measurements.h"
// CAN Libraries
// #include <circular_buffer.h>
// #include <FlexCAN_T4.h>
// #include <imxrt_flexcan.h>
// #include <kinetis_flexcan.h>

extern "C" uint32_t set_arm_clock(uint32_t frequency);

enum STATE {
  STATE_START,
  STATE_PRECHARGE,
  STATE_ONLINE,
  STATE_SHUTDOWN,
  STATE_ERROR,
  STATE_DEBUG
} state = STATE_DEBUG;

enum MODE {
  MODE_VOLTAGE_95   = 0b00000000,
  MODE_TIMER_3      = 0b00000001,
  MODE_TIMER_5      = 0b00000010,
  MODE_TIMER_8      = 0b00000011,
  MODE_DEBUG        = 0b00000111
} mode = MODE_VOLTAGE_95;

enum ERR_CODE {
  ERR_NONE,
  ERR_V_SUPP_LOW,
  ERR_TIMEOUT
} errCode = ERR_NONE;


unsigned long startTime;



void setup() {
  // set_arm_clock(16000000); // Takes the idle current draw from 200mA to 150mA
  Serial.begin(115200);

  Serial.print("F_CPU_ACTUAL=");
  Serial.println(F_CPU_ACTUAL);
  // Initialise IO
  setupGPIO();

}


void loop() {
    double vA = getAccuVoltage();
    double vT = getTsVoltage();
    // double f = getFrequency(FREQ_ACCU_PIN);
    // Serial.println(f);

    double sum = 0;
    for (int i = 0; i < 20; i++) {
      sum += getAccuVoltage() - getTsVoltage();
    }

    Serial.println(sum/20.0);

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
  if (pwrVolts >= 11.2 || mode != MODE_DEBUG){
    state = STATE_PRECHARGE;
  } else {
    state = STATE_ERROR;
    errCode = ERR_V_SUPP_LOW;
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
  state = STATE_START;
}
