#include "Arduino.h"
#include "moving-average.h"


MovingAverage::MovingAverage(double average, double alpha)
{
  _average = average;
  _alpha = alpha;
}

// Update the moving average and return new average
double MovingAverage::update(double sample)
{
  _average = _alpha * sample + (1.0 - _alpha) * _average;
  return _average;
}

// Get average value without updating
double MovingAverage::value()
{
  return _average;
}
