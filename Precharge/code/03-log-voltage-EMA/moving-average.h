/*
  moving-average.h - Library for running an exponential moving average
  https://en.wikipedia.org/wiki/Moving_average#Exponential_moving_average
  Created by Michael Ruppe, 20 April, 2020.
*/
#ifndef Moving_average_h
#define Moving_average_h

#include "Arduino.h"

class MovingAverage
{
  public:
    MovingAverage(double average, double alpha);
    double update(double sample);
    double value();
  private:
    double _average;
    double _alpha;
};

#endif
