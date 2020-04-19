/*
  Voltage to Frequency: linear fit parameters
  Capacitors have a generally poor tolerance, so the response we get
  from LM331 V-F converter will be different from the ideal specified
  in the datasheet. However, the response should still be extremely
  stable and linear.
  Perform a Voltage to Frequency experiment:
  Set Vin = 0 to 9 Volts
  Record frequency output for severl samples
  calculate linear fits
  define the necessary constants in this file, such that
  freq = f(Vin) = V2F_slope * Vin + V2F_ofs
*/

// Accumulator V-F converter - Schematic REF : U8
const double V2F_slope_accu = 754.44;
const double V2F_ofs_accu = 0.1405;

// Tractive System V-F converter - Schematic REF: U7
const double V2F_slope_ts = 740.63;
const double V2F_ofs_ts = -3.7241;

double freqToVoltage(int channel, )

// Tractive system components
const double Rpre = 390.0;  // Ohms
const double Cts = 1000;    // micro-Farads: Total TS capacitance
const double Rpar = 4700;   // Ohms Parasitic capacitance (parallel to TS capacitor)
                            // If unknown or extremely large just enter 1e8

/*

            Rpre       Vts
+__________XXXX____________
                   |       |
Vaccu         Cts ---      X Rpar
                  ---      X
-__________________|_______|


*/
