# Precharge

A device to precharge the Tractive System. This prototype features voltage feedback to protect AIRs. In open-loop systems, if a wiring fault develops (eg. precharge resistor is disconnected or discharge is stuck on) then the precharge is ineffective and AIRs may become damaged.
<div align="center">
<img src="Precharge-render.png" width="400">
<p>Figure 1: The prototype Precharge module</p>
</div>

**Directories**
- [code/precharge](code/precharge) - The source code
- [Precharge](Precharge) - The PCB design files

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

## Recommendations after building prototype

**V-F Conversion**: Either include offset in V-F converter circuit so that min frequency is eg ~100Hz instead of 0Hz ([Datasheet](https://www.ti.com/lit/ds/symlink/lm331.pdf): Figure 14) or replace V-F converters with microcontroller programmed for the same task. The challenge is that low frequencies require a long timeout period. Applying a 100Hz offset means the longest timeout would be 10 milli-seconds.
