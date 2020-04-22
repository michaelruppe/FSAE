# Precharge

A device to precharge the Tractive System. This prototype features voltage feedback to protect AIRs. In open-loop systems, if a wiring fault develops (eg. precharge resistor is disconnected or discharge is stuck on) then the precharge is ineffective and AIRs may become damaged.
<div align="center">
<img src="Precharge-render.png" width="400">
<p>Figure 1: The prototype Precharge module</p>
</div>

**Directories**
- [code/precharge](code/precharge) - The source code
- [Precharge](Precharge) - The PCB design files
- [docs](docs) - Data collected during commissioning, image assets for this document.

## Specifications & Features
- Wide input voltage 0 - 600V
- Powered by shutdown circuit: 12V
- Integrated PDOC
- Isolated HV measurement
- CAN interface (provisional) for status output
- Serial interface for collecting commissioning




## Operation
A brief description of the Precharge logic follows. Refer to *Figures 2 & 3* for state-flow information.
- Initialise in `State: Standby` and monitor for a stable Shutdown Circuit.
- If Shutdown Circuit is stable, enter `State: Precharge`:
  - Close the precharge relay
  - Monitor Accumulator voltage and Tractive System voltage
  - Once TSV is close enough to AV (eg >95%), precharge is complete
  - If precharge is too fast or too slow, a fault is likely present eg. Wiring fault, discharge stuck-on, stuck relay.
- If precharge completed with no errors, proceed to `State: Online`:
  - Enable the AIR, open precharge relay

If at any point the Shutdown Circuit voltage becomes too low, enter `State: Standby`

<div align="center">
<img src="docs/state-flow-chart.png" width="800">
<p>Figure 2: A top-level look at the state-flow behaviour</p>
</div>
<div align="center">
<img src="docs/timing-diagram.png" width="800">
<p>Figure 3: A timing diagram illustrating a precharge sequence. When the TS voltage reaches the target voltage, precharge is complete and the AIR closes. The target voltage should be 90-95% of the Accumulator voltage</p>
</div>

## Commissioning Instructions
*Refer to [docs/Experiments.xlsx](docs/Experiments.xlsx) for sample data collected during prototype construction.*

### Characterise Voltage-Frequency
- Assemble power supply components and V-F converter circuitry `U5 - U9`.
- Characterise voltage-frequency performance: perform V-F experiment `code/01-v-f-experiment` *Refer to Figure 4 for sample data collected during prototype construction*
  - Apply 0.15-10V at V-F inputs: `TP5, TP6`.
  - Record output frequencies: `TP1, TP2` vs input voltages.
  - Create linear fit and record the gain and offset parameters.
  - Update [code/precharge/measurements.cpp](code/precharge/measurements.cpp) with the linear-fit parameters: `V2F_slope_accu, V2F_ofs_accu, V2F_slope_ts, V2F_ofs_ts`
- If resistors `R31,R32,R36-39` or `R33,R34,R40-R3` are different to schematic:
  - Find the gain of these voltage dividers: eg `Gain = R39/(R31+R32+R36+R37+R38+R39)`
  - Update [code/precharge/measurements.cpp](code/precharge/measurements.cpp): `gainVoltageDivider` with the new gain value.


  <div align="center">
  <img src="docs/v-f-characteristic.png" width="800">
  <p>Figure 4: Results from the V-F experiment - data collected from the prototype during construction. The V-F response is extremely linear. Expect f(0V) = 0Hz, which is supported by very small y-intercept constants. While the V-F converter circuits are nominally identical, they should be characterised separately to account for component tolerance.</p>
  </div>

### Simulate Precharge
Here, we simulate a precharge sequence using low voltages that bypass the large voltage dividers.

*Voltages listed are referenced to the `GNDS` net, connector `J3` labelled `TS-`*
- Connect a known capacitive load eg 1000uF to `TP6`. Include a large parallel resistance (eg 20k) for capacitor discharge.
  - The voltage divider created by this resistance and the precharge resistor `R46` will limit the maximum voltage seen at capacitor. Large resistances will reduce this effect, but the capacitor will discharge more slowly during this test.
- Apply 10V to `HV IN`
- Monitor serial data from the microcontroller via USB
- Power the circuit at `J1`
- Monitor precharge behaviour in serial console and note precharge percentage and duration.
- Modify and upload [code/precharge/precharge.ino](code/precharge/precharge.ino) as necessary. Relevant parameters are:
  - `MIN_EXPECTED`[ms] The minimum allowable precharge time. Times faster than this are likely due to wiring fault.
  - `MAX_EXPECTED`[ms] The maximum allowable precharge time. Times slower than this are likely due to wiring fault, stuck discharge circuit.
  - `TARGET_PERCENT`[%] The target percentage of accumulator voltage to precharge to.
    - The discharge resistance used during this simulation affects the maximum TS voltage attainable. I found a maximum voltage of only 90% when using Precharge:390Ohm and discharge 4k7.


## Recommendations after building prototype

**V-F Conversion**: Either include offset in V-F converter circuit so that min frequency is eg ~100Hz instead of 0Hz ([Datasheet](https://www.ti.com/lit/ds/symlink/lm331.pdf): Figure 14) or replace V-F converters with microcontroller programmed for the same task. The challenge is that low frequencies require a long timeout period. Applying a 100Hz offset means the longest timeout would be 10 milli-seconds.
