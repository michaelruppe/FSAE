/*
  moving-average.h - Library for running an exponential moving average
  https://en.wikipedia.org/wiki/Moving_average#Exponential_moving_average
  Created by Michael Ruppe, 20 April, 2020.


  EXAMPLE USAGE: keep a moving average of some data:

      MovingAverage movingAverage(0, 0.1); // Initial value = 0, alpha = 0.1
      double avg;

      // update the moving average with some data and return the moving average
      avg = movingAverage.update(100.0);
      Serial.print(avg);
      avg = movingAverage.update(105.8);
      Serial.print(avg);
      avg = movingAverage.update(121.89);
      Serial.print(avg);


      // It's also possible to retrieve without updating:
      avg = averageData.value(); // Retrieve the moving average
      Serial.print(avg);

*/

#ifndef Moving_average_h
#define Moving_average_h

#include "Arduino.h"

class MovingAverage
{
  public:
    MovingAverage(double initial, double alpha);
    double update(double sample);
    double value();
    void reset();
  private:
    double _average;
    double _initialAverage;
    double _alpha;
};

#endif
