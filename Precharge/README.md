# Precharge

The Precharge project aims to safely and reliably precharge the Tractive System. Voltage-feedback allows for minimal, exact precharge timing and error-detection.


## Recommendations after building prototype

**V-F Conversion**: Either include offset in V-F converter circuit so that min frequency is eg ~100Hz ([Datasheet](https://www.ti.com/lit/ds/symlink/lm331.pdf): Figure 14) or replace V-F converters with microcontroller programmed for the same task. The challenge is that low frequencies require a long timeout period. Applying a 100Hz offset means the longest timeout would be 10 milli-seconds.
