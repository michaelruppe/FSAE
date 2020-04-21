# Precharge Source Code

There are several code projects here, each maturing as the prototype is commissioned.
The library source files have evolved as the prototype evolves - eg. measurements.cpp
from one project will not be the same as another.

## Projects listed by maturity
- [01-v-f-experiment](01-v-f-experiment/) Used to measure the characteristics of V-F converters
- [02-log-voltage](02-log-voltage/) Using the data obtained in the v-f expermiment to log voltage information
for TS and Accumulator in a precharge bench-experiment
- [03-log-voltage-EMA](03-log-voltage-EMA/) The same as `02` but now an Exponential Moving Average class is included to filter voltage data - virtually removing spurious peaks entirely.
- [precharge](precharge/) The final precharge program.
