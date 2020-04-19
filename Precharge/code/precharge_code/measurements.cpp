/*
  Voltage to Frequency: linear fit parameters
  Perform a Voltage to Frequency experiment (Precharge/code/v-f-experiment/)
  Record frequency output for several samples
  calculate linear fits
  define the necessary constants in this file, such that
  freq = f(Vin) = V2F_slope * Vin + V2F_ofs
*/

#include "measurements.h"
#include "gpio.h"

// Accumulator V-F converter - Schematic REF : U8
const double V2F_slope_accu = 754.44;   // Gradient constant
const double V2F_ofs_accu = 0.1405;     // offset / y-intercept consant

// Tractive System V-F converter - Schematic REF: U7
const double V2F_slope_ts = 740.63;     // Gradient constant
const double V2F_ofs_ts = -3.7241;      // offset / y-intercept consant

// Voltage dividers upstream of V-F converters:
// R1 = 2.55M, R2 = 39k
// gain = R2/(R1+R2)
const double gainVoltageDivider = 0.01506373117;


// Calculate the HIGH voltage at Accumulator or TS
// convert frequency to voltage: inverse of the linear characteristic
// y = mx+b becomes x = (y-b)/m
// scale voltage by voltage-divider
double getTsVoltage() {
  double f = getFrequency(FREQ_TS_PIN);
  double v = (f - V2F_ofs_ts)/V2F_slope_ts;
  return v / gainVoltageDivider;
}
// I know duplicating code is a no-no but who wants to write classes for this?!
double getAccuVoltage() {
  double f = getFrequency(FREQ_ACCU_PIN);
  if (f == 0) return 0; // frequency measurement timed-out
  double v = (f - V2F_ofs_accu)/V2F_slope_accu;
  return v / gainVoltageDivider;

}


// Measure the frequency at a pin by measuring a pulse train.
// Do not assume 50% duty cycle, instead, measure a high pulse and a low pulse
// separately. This will combine measurements from two separate wavelengths, but
// that's fine with me.
double getFrequency(int pin) {
  const unsigned int TIMEOUT = 10000;
  unsigned int tHigh = pulseIn(pin, HIGH, TIMEOUT);  // microseconds
  unsigned int tLow = pulseIn(pin,LOW, TIMEOUT);
  if (tHigh == 0 || tLow == 0){
    return 0; // timed out
  }
  return round(1/(1e-6 * (double)(tHigh + tLow)));    // f = 1/T
}


// DEPRECATED: here we could just use the map function if we have collected
// min/max voltage and min/max frequency
double getVoltage(int pin) {
  double freq = getFrequency(pin);
  return (double)map(freq,0,10000,0,610); // TODO: use sensible values. SYSID
}
