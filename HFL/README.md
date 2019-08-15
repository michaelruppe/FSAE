# Hard Fault Latch
A shutdown-circuit component.

![](HFL.png)

The **Hard Fault Latch (HFL)** is a device that breaks the *Shutdown Circuit* when a fault is detected by the IMD, BMS, BSPD or PDOC-temperature boards. A Hard Fault is any fault that will deactivate the Tractive System, and cannot be reset by the driver. This is achieved with relay logic.

Presently, an operator must press the Hard Fault Reset button (J3:RESET) each time the vehicle is powered-up, before the Tractive System can be activated.

Additionally, the HFL is capable of driving (low-side) fault-indicator lamps up to 200mA.
