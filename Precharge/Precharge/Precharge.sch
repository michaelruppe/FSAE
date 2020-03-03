EESchema Schematic File Version 4
LIBS:Precharge-cache
EELAYER 29 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:D D4
U 1 1 5E2BB9EB
P 13300 5750
F 0 "D4" H 13300 5966 50  0000 C CNN
F 1 "D" H 13300 5875 50  0000 C CNN
F 2 "Diode_SMD:D_SMA" H 13300 5750 50  0001 C CNN
F 3 "~" H 13300 5750 50  0001 C CNN
	1    13300 5750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 5E32C777
P 13550 8300
F 0 "R11" V 13343 8300 50  0000 C CNN
F 1 "10k" V 13434 8300 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 13480 8300 50  0001 C CNN
F 3 "~" H 13550 8300 50  0001 C CNN
	1    13550 8300
	0    -1   -1   0   
$EndComp
$Comp
L precharge-library:GLV- #PWR020
U 1 1 5E3C4990
P 13850 8350
F 0 "#PWR020" H 13850 8200 50  0001 C CNN
F 1 "GLV-" H 13865 8523 50  0000 C CNN
F 2 "" H 13850 8350 50  0001 C CNN
F 3 "" H 13850 8350 50  0001 C CNN
	1    13850 8350
	-1   0    0    1   
$EndComp
$Comp
L Transistor_FET:2N7002 Q2
U 1 1 5E415604
P 13750 8050
F 0 "Q2" H 13956 8096 50  0000 L CNN
F 1 "2N7002" H 13956 8005 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 13950 7975 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N7002.pdf" H 13750 8050 50  0001 L CNN
	1    13750 8050
	1    0    0    -1  
$EndComp
Wire Wire Line
	13850 8350 13850 8300
Wire Wire Line
	13700 8300 13850 8300
Connection ~ 13850 8300
Wire Wire Line
	13850 8300 13850 8250
Wire Wire Line
	13400 8300 13400 8050
Connection ~ 13400 8050
Wire Wire Line
	13400 8050 13550 8050
$Comp
L MCU_Microchip_ATtiny:ATtiny85V-10SU U2
U 1 1 5E5D08BE
P 3950 8050
F 0 "U2" H 3420 8096 50  0000 R CNN
F 1 "ATtiny85V-10SU" H 3420 8005 50  0000 R CNN
F 2 "Package_SO:SOIJ-8_5.3x5.3mm_P1.27mm" H 3950 8050 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/atmel-2586-avr-8-bit-microcontroller-attiny25-attiny45-attiny85_datasheet.pdf" H 3950 8050 50  0001 C CNN
	1    3950 8050
	1    0    0    -1  
$EndComp
Text Label 5000 7750 0    50   ~ 0
MOSI
Text Label 4700 7850 0    50   ~ 0
MISO
Text Label 4700 7950 0    50   ~ 0
SCK
Text Label 5350 8250 0    50   ~ 0
~RESET
Wire Wire Line
	4550 7850 4700 7850
Wire Wire Line
	4550 7950 4700 7950
Wire Wire Line
	4550 8250 4800 8250
$Comp
L power:+5V #PWR07
U 1 1 5E5E5AA2
P 3950 7100
F 0 "#PWR07" H 3950 6950 50  0001 C CNN
F 1 "+5V" H 3965 7273 50  0000 C CNN
F 2 "" H 3950 7100 50  0001 C CNN
F 3 "" H 3950 7100 50  0001 C CNN
	1    3950 7100
	1    0    0    -1  
$EndComp
$Comp
L precharge-library:GLV- #PWR08
U 1 1 5E5E5F58
P 3950 8800
F 0 "#PWR08" H 3950 8650 50  0001 C CNN
F 1 "GLV-" H 3965 8973 50  0000 C CNN
F 2 "" H 3950 8800 50  0001 C CNN
F 3 "" H 3950 8800 50  0001 C CNN
	1    3950 8800
	-1   0    0    1   
$EndComp
Wire Wire Line
	3950 8800 3950 8650
Wire Wire Line
	3950 7450 3950 7300
$Comp
L power:+12V #PWR019
U 1 1 5E5E8BD6
P 13000 5750
F 0 "#PWR019" H 13000 5600 50  0001 C CNN
F 1 "+12V" H 13015 5923 50  0000 C CNN
F 2 "" H 13000 5750 50  0001 C CNN
F 3 "" H 13000 5750 50  0001 C CNN
	1    13000 5750
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x03_Odd_Even J2
U 1 1 5E5D028E
P 3300 9900
F 0 "J2" H 3350 10217 50  0000 C CNN
F 1 "ISP" H 3350 10126 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x03_P2.54mm_Vertical" H 3300 9900 50  0001 C CNN
F 3 "~" H 3300 9900 50  0001 C CNN
	1    3300 9900
	1    0    0    -1  
$EndComp
Text Label 2500 9800 2    50   ~ 0
MISO
Text Label 2500 9900 2    50   ~ 0
SCK
Text Label 2500 10000 2    50   ~ 0
~RESET
Text Label 3800 9900 0    50   ~ 0
MOSI
$Comp
L power:+5V #PWR05
U 1 1 5E5D0F88
P 3800 9800
F 0 "#PWR05" H 3800 9650 50  0001 C CNN
F 1 "+5V" H 3815 9973 50  0000 C CNN
F 2 "" H 3800 9800 50  0001 C CNN
F 3 "" H 3800 9800 50  0001 C CNN
	1    3800 9800
	1    0    0    -1  
$EndComp
$Comp
L precharge-library:GLV- #PWR06
U 1 1 5E5D12A7
P 3800 10000
F 0 "#PWR06" H 3800 9850 50  0001 C CNN
F 1 "GLV-" H 3815 10173 50  0000 C CNN
F 2 "" H 3800 10000 50  0001 C CNN
F 3 "" H 3800 10000 50  0001 C CNN
	1    3800 10000
	-1   0    0    1   
$EndComp
Wire Wire Line
	2500 9800 2750 9800
Wire Wire Line
	2500 9900 3050 9900
Wire Wire Line
	2500 10000 3100 10000
Wire Wire Line
	3600 10000 3800 10000
Wire Wire Line
	3800 9900 3600 9900
Wire Wire Line
	3600 9800 3800 9800
$Comp
L precharge-library:GLV- #PWR02
U 1 1 5E3099D1
P 2150 2150
F 0 "#PWR02" H 2150 2000 50  0001 C CNN
F 1 "GLV-" H 2165 2323 50  0000 C CNN
F 2 "" H 2150 2150 50  0001 C CNN
F 3 "" H 2150 2150 50  0001 C CNN
	1    2150 2150
	-1   0    0    1   
$EndComp
$Comp
L Device:D D1
U 1 1 5E30DFA0
P 2000 1800
F 0 "D1" H 2000 1584 50  0000 C CNN
F 1 "D" H 2000 1675 50  0000 C CNN
F 2 "Diode_SMD:D_SMA" H 2000 1800 50  0001 C CNN
F 3 "~" H 2000 1800 50  0001 C CNN
	1    2000 1800
	-1   0    0    1   
$EndComp
Wire Wire Line
	1800 1800 1850 1800
$Comp
L Device:C C2
U 1 1 5E3100D6
P 2800 1950
F 0 "C2" H 2915 1996 50  0000 L CNN
F 1 "220u" H 2915 1905 50  0000 L CNN
F 2 "Capacitor_SMD:C_Elec_6.3x5.4" H 2838 1800 50  0001 C CNN
F 3 "~" H 2800 1950 50  0001 C CNN
	1    2800 1950
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR04
U 1 1 5E314983
P 3350 1000
F 0 "#PWR04" H 3350 850 50  0001 C CNN
F 1 "+12V" H 3365 1173 50  0000 C CNN
F 2 "" H 3350 1000 50  0001 C CNN
F 3 "" H 3350 1000 50  0001 C CNN
	1    3350 1000
	1    0    0    -1  
$EndComp
Connection ~ 2800 1800
Connection ~ 2800 2100
Wire Wire Line
	3950 2100 3950 1850
$Comp
L Device:C C3
U 1 1 5E384B0E
P 4400 1800
F 0 "C3" H 4515 1846 50  0000 L CNN
F 1 "1u" H 4515 1755 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 4438 1650 50  0001 C CNN
F 3 "~" H 4400 1800 50  0001 C CNN
	1    4400 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3950 2100 4400 2100
Wire Wire Line
	4400 2100 4400 1950
Connection ~ 3950 2100
Wire Wire Line
	4400 1550 4400 1650
$Comp
L power:+5V #PWR09
U 1 1 5E388C77
P 4400 1000
F 0 "#PWR09" H 4400 850 50  0001 C CNN
F 1 "+5V" H 4415 1173 50  0000 C CNN
F 2 "" H 4400 1000 50  0001 C CNN
F 3 "" H 4400 1000 50  0001 C CNN
	1    4400 1000
	1    0    0    -1  
$EndComp
Connection ~ 4400 1550
Wire Wire Line
	3350 1800 3350 1550
Wire Wire Line
	3350 1550 3650 1550
Wire Wire Line
	2800 1800 3350 1800
Wire Wire Line
	2150 1800 2400 1800
Wire Wire Line
	2150 2100 2400 2100
$Comp
L Device:C C1
U 1 1 5E3F6DDF
P 2400 1950
F 0 "C1" H 2515 1996 50  0000 L CNN
F 1 "100n" H 2515 1905 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 2438 1800 50  0001 C CNN
F 3 "~" H 2400 1950 50  0001 C CNN
	1    2400 1950
	1    0    0    -1  
$EndComp
Connection ~ 2400 1800
Wire Wire Line
	2400 1800 2800 1800
Connection ~ 2400 2100
Wire Wire Line
	2400 2100 2800 2100
Wire Wire Line
	2800 2100 3950 2100
Text Notes 950  2050 0    50   ~ 0
Shutdown Circuit IN
Wire Wire Line
	2150 2150 2150 2100
Wire Wire Line
	1800 2050 1800 1800
Connection ~ 1800 1800
Connection ~ 2150 2150
Text Label 1850 2900 0    50   ~ 0
SHTDN_OUT
$Comp
L Device:R R4
U 1 1 5E5FDEDC
P 4800 8400
F 0 "R4" V 4593 8400 50  0000 C CNN
F 1 "10k" V 4684 8400 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 4730 8400 50  0001 C CNN
F 3 "~" H 4800 8400 50  0001 C CNN
	1    4800 8400
	1    0    0    -1  
$EndComp
Connection ~ 4800 8250
$Comp
L power:+5V #PWR011
U 1 1 5E5FE433
P 4800 8550
F 0 "#PWR011" H 4800 8400 50  0001 C CNN
F 1 "+5V" H 4815 8723 50  0000 C CNN
F 2 "" H 4800 8550 50  0001 C CNN
F 3 "" H 4800 8550 50  0001 C CNN
	1    4800 8550
	-1   0    0    1   
$EndComp
$Comp
L Device:R R2
U 1 1 5E61AE9B
P 2750 9200
F 0 "R2" V 2543 9200 50  0000 C CNN
F 1 "100k" V 2634 9200 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 2680 9200 50  0001 C CNN
F 3 "~" H 2750 9200 50  0001 C CNN
	1    2750 9200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 5E61B59B
P 3050 9200
F 0 "R3" V 2843 9200 50  0000 C CNN
F 1 "100k" V 2934 9200 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 2980 9200 50  0001 C CNN
F 3 "~" H 3050 9200 50  0001 C CNN
	1    3050 9200
	1    0    0    -1  
$EndComp
Wire Wire Line
	2750 9350 2750 9800
Connection ~ 2750 9800
Wire Wire Line
	2750 9800 3100 9800
Wire Wire Line
	3050 9350 3050 9900
Connection ~ 3050 9900
Wire Wire Line
	3050 9900 3100 9900
$Comp
L power:+5V #PWR03
U 1 1 5E620F74
P 2900 8900
F 0 "#PWR03" H 2900 8750 50  0001 C CNN
F 1 "+5V" H 2915 9073 50  0000 C CNN
F 2 "" H 2900 8900 50  0001 C CNN
F 3 "" H 2900 8900 50  0001 C CNN
	1    2900 8900
	1    0    0    -1  
$EndComp
Wire Wire Line
	2750 9050 2750 8950
Wire Wire Line
	2750 8950 2900 8950
Wire Wire Line
	2900 8950 2900 8900
Wire Wire Line
	2900 8950 3050 8950
Wire Wire Line
	3050 8950 3050 9050
Connection ~ 2900 8950
$Comp
L precharge-library:GLV+ #PWR01
U 1 1 5E30CE8D
P 1800 1800
F 0 "#PWR01" H 1800 1650 50  0001 C CNN
F 1 "GLV+" H 1815 1973 50  0000 C CNN
F 2 "" H 1800 1800 50  0001 C CNN
F 3 "" H 1800 1800 50  0001 C CNN
	1    1800 1800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	850  2150 2150 2150
Wire Wire Line
	850  2050 1800 2050
$Comp
L Connector:Conn_01x06_Female J1
U 1 1 5E5E8823
P 650 2250
F 0 "J1" H 542 2535 50  0000 C CNN
F 1 "MicroFit" H 600 1850 50  0000 C CNN
F 2 "Connector_Molex:Molex_Micro-Fit_3.0_43045-0612_2x03_P3.00mm_Vertical" H 650 2250 50  0001 C CNN
F 3 "~" H 650 2250 50  0001 C CNN
	1    650  2250
	-1   0    0    -1  
$EndComp
Wire Notes Line
	3300 9450 3300 8600
Wire Notes Line
	3300 8600 2450 8600
Wire Notes Line
	2450 8600 2450 9450
Wire Notes Line
	2450 9450 3300 9450
Text Notes 2400 8600 0    50   ~ 0
CONFIG resistors
Wire Wire Line
	4550 7750 5000 7750
$Comp
L precharge-library:G7L-2A-X-L K2
U 1 1 5E70E36D
P 13300 6600
F 0 "K2" V 14000 6350 50  0000 L CNN
F 1 "G7L-2A-X-L" V 14000 6500 50  0000 L CNN
F 2 "Precharge:G7L-2A-X-L" H 13300 6600 50  0001 C CNN
F 3 "https://omronfs.omron.com/en_US/ecb/products/pdf/en-g7l_x.pdf" H 13300 6600 50  0001 C CNN
	1    13300 6600
	0    1    1    0   
$EndComp
Wire Wire Line
	13000 6750 12850 6750
Wire Wire Line
	12850 6750 12850 7000
Wire Wire Line
	12850 7000 13000 7000
Text Notes 10400 9950 0    50   ~ 0
To pre-charge resistor\nhttps://www.digikey.com.au/product-detail/en/te-connectivity-passive-product/THS50220RJ/A132044-ND/2366813\n\nHSC150220RJ
Wire Wire Line
	13600 6250 13700 6250
Wire Wire Line
	13000 6250 13000 5750
Wire Wire Line
	13150 5750 13000 5750
Connection ~ 13000 5750
Wire Wire Line
	13450 5750 13700 5750
Wire Wire Line
	13700 5750 13700 6250
Connection ~ 13700 6250
Wire Wire Line
	850  2250 1800 2250
Wire Wire Line
	1800 2250 1800 2350
$Comp
L Device:R R1
U 1 1 5E73D05B
P 1550 2350
F 0 "R1" V 1343 2350 50  0000 C CNN
F 1 "10k" V 1434 2350 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 1480 2350 50  0001 C CNN
F 3 "~" H 1550 2350 50  0001 C CNN
	1    1550 2350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1800 2350 1700 2350
Connection ~ 1800 2350
Wire Wire Line
	1400 2350 850  2350
Text Label 950  2350 0    50   ~ 0
PRECH_STS
$Comp
L Device:D D2
U 1 1 5E5E399D
P 3950 1150
F 0 "D2" H 3950 934 50  0000 C CNN
F 1 "D" H 3950 1025 50  0000 C CNN
F 2 "Diode_SMD:D_SMA" H 3950 1150 50  0001 C CNN
F 3 "~" H 3950 1150 50  0001 C CNN
	1    3950 1150
	1    0    0    1   
$EndComp
Wire Wire Line
	4400 1550 4400 1150
Wire Wire Line
	4400 1150 4100 1150
Wire Wire Line
	3350 1550 3350 1150
Wire Wire Line
	3350 1150 3800 1150
Connection ~ 3350 1550
Wire Wire Line
	3350 1000 3350 1150
Connection ~ 3350 1150
Wire Wire Line
	4400 1000 4400 1150
Connection ~ 4400 1150
$Comp
L Device:R R10
U 1 1 5E5EE74D
P 13150 8050
F 0 "R10" V 12943 8050 50  0000 C CNN
F 1 "220" V 13034 8050 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 13080 8050 50  0001 C CNN
F 3 "~" H 13150 8050 50  0001 C CNN
	1    13150 8050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	13300 8050 13400 8050
Text Label 6750 8050 0    50   ~ 0
PRECHG
Wire Wire Line
	13600 2650 12950 2650
$Comp
L Device:R R8
U 1 1 5E5FD3EE
P 12650 2400
F 0 "R8" V 12443 2400 50  0000 C CNN
F 1 "10k" V 12534 2400 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 12580 2400 50  0001 C CNN
F 3 "~" H 12650 2400 50  0001 C CNN
	1    12650 2400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 5E5FDAC5
P 12650 3150
F 0 "R9" V 12443 3150 50  0000 C CNN
F 1 "10k" V 12534 3150 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 12580 3150 50  0001 C CNN
F 3 "~" H 12650 3150 50  0001 C CNN
	1    12650 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	13600 2850 13350 2850
Wire Wire Line
	12650 3300 12650 3450
$Comp
L Device:C C5
U 1 1 5E615F59
P 12950 3200
F 0 "C5" H 13065 3246 50  0000 L CNN
F 1 "100n" H 13065 3155 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 12988 3050 50  0001 C CNN
F 3 "~" H 12950 3200 50  0001 C CNN
	1    12950 3200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C6
U 1 1 5E616962
P 13350 3200
F 0 "C6" H 13465 3246 50  0000 L CNN
F 1 "100n" H 13465 3155 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 13388 3050 50  0001 C CNN
F 3 "~" H 13350 3200 50  0001 C CNN
	1    13350 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	12950 3050 12950 2650
Wire Wire Line
	13350 3050 13350 2850
Wire Wire Line
	12650 3450 12950 3450
Wire Wire Line
	12950 3450 12950 3350
Wire Wire Line
	12950 3450 13350 3450
Wire Wire Line
	13350 3450 13350 3350
Connection ~ 12950 3450
Wire Wire Line
	1800 2350 1800 2900
$Comp
L Comparator:MCP6562 U3
U 1 1 5E630F4E
P 13900 2750
F 0 "U3" H 13900 3117 50  0000 C CNN
F 1 "MCP6562" H 13900 3026 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 13900 2750 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/22139C.pdf" H 13900 2750 50  0001 C CNN
	1    13900 2750
	1    0    0    -1  
$EndComp
Text Notes 14150 2600 0    50   ~ 0
Push-pull output
Wire Wire Line
	12650 2550 12650 2850
Connection ~ 12950 2650
Wire Wire Line
	13350 2850 12650 2850
Connection ~ 13350 2850
Connection ~ 12650 2850
Wire Wire Line
	12650 2850 12650 3000
$Comp
L Comparator:MCP6562 U3
U 3 1 5E650124
P 8350 10150
F 0 "U3" H 8162 10104 50  0000 R CNN
F 1 "MCP6562" H 8162 10195 50  0000 R CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 8350 10150 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/22139C.pdf" H 8350 10150 50  0001 C CNN
	3    8350 10150
	1    0    0    1   
$EndComp
$Comp
L Device:R R12
U 1 1 5E654433
P 14450 2750
F 0 "R12" V 14243 2750 50  0000 C CNN
F 1 "100" V 14334 2750 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 14380 2750 50  0001 C CNN
F 3 "~" H 14450 2750 50  0001 C CNN
	1    14450 2750
	0    1    -1   0   
$EndComp
Wire Wire Line
	14200 2750 14300 2750
Text Label 14850 2750 0    50   ~ 0
PDOC
Wire Wire Line
	14850 2750 14600 2750
$Comp
L precharge-library:GLV- #PWR016
U 1 1 5E662C3D
P 8250 10550
F 0 "#PWR016" H 8250 10400 50  0001 C CNN
F 1 "GLV-" H 8265 10723 50  0000 C CNN
F 2 "" H 8250 10550 50  0001 C CNN
F 3 "" H 8250 10550 50  0001 C CNN
	1    8250 10550
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR015
U 1 1 5E663033
P 8250 9750
F 0 "#PWR015" H 8250 9600 50  0001 C CNN
F 1 "+5V" H 8265 9923 50  0000 C CNN
F 2 "" H 8250 9750 50  0001 C CNN
F 3 "" H 8250 9750 50  0001 C CNN
	1    8250 9750
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 10550 8250 10500
Wire Wire Line
	8250 9850 8250 9800
$Comp
L Device:C C4
U 1 1 5E66AC95
P 8500 10150
F 0 "C4" H 8615 10196 50  0000 L CNN
F 1 "100n" H 8615 10105 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 8538 10000 50  0001 C CNN
F 3 "~" H 8500 10150 50  0001 C CNN
	1    8500 10150
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 9800 8500 9800
Wire Wire Line
	8500 9800 8500 10000
Connection ~ 8250 9800
Wire Wire Line
	8250 9800 8250 9750
Wire Wire Line
	8250 10500 8500 10500
Wire Wire Line
	8500 10500 8500 10300
Connection ~ 8250 10500
Wire Wire Line
	8250 10500 8250 10450
Text Label 950  2450 0    50   ~ 0
PDOC
Wire Wire Line
	950  2450 850  2450
Connection ~ 12650 3450
$Comp
L power:+5V #PWR017
U 1 1 5E64EAA1
P 12350 2250
F 0 "#PWR017" H 12350 2100 50  0001 C CNN
F 1 "+5V" H 12365 2423 50  0000 C CNN
F 2 "" H 12350 2250 50  0001 C CNN
F 3 "" H 12350 2250 50  0001 C CNN
	1    12350 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	12150 2250 12350 2250
Connection ~ 12150 2650
Wire Wire Line
	12950 2650 12150 2650
Wire Wire Line
	12150 3000 12150 2650
Wire Wire Line
	12150 3300 12150 3450
$Comp
L precharge-library:GLV- #PWR018
U 1 1 5E6040B6
P 12400 3450
F 0 "#PWR018" H 12400 3300 50  0001 C CNN
F 1 "GLV-" H 12415 3623 50  0000 C CNN
F 2 "" H 12400 3450 50  0001 C CNN
F 3 "" H 12400 3450 50  0001 C CNN
	1    12400 3450
	-1   0    0    1   
$EndComp
$Comp
L Device:R R7
U 1 1 5E5F31BE
P 12150 3150
F 0 "R7" V 11943 3150 50  0000 C CNN
F 1 "10k" V 12034 3150 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 12080 3150 50  0001 C CNN
F 3 "~" H 12150 3150 50  0001 C CNN
	1    12150 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:Thermistor TH1
U 1 1 5E5EFB99
P 12150 2450
F 0 "TH1" H 12045 2404 50  0000 R CNN
F 1 "TFPT1206L1002FM" H 12045 2495 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric" H 12150 2450 50  0001 C CNN
F 3 "~" H 12150 2450 50  0001 C CNN
	1    12150 2450
	1    0    0    1   
$EndComp
Connection ~ 12350 2250
Wire Wire Line
	12350 2250 12650 2250
Connection ~ 12400 3450
Wire Wire Line
	12400 3450 12150 3450
Wire Wire Line
	12400 3450 12650 3450
Text Notes 11350 2000 0    50   ~ 10
PDOC - Thermal overload protection for precharge resistor
Wire Notes Line width 8
	11150 2000 15200 2000
Wire Notes Line width 8
	15200 2000 15200 3850
Wire Notes Line width 8
	15200 3850 11150 3850
Wire Notes Line width 8
	11150 2000 11150 3850
Wire Wire Line
	5850 1600 6100 1600
Connection ~ 5850 1600
Wire Wire Line
	5850 1100 5850 1600
Wire Wire Line
	5550 1100 5850 1100
Wire Wire Line
	4950 1600 5100 1600
Connection ~ 4950 1600
Wire Wire Line
	4950 1100 4950 1600
Wire Wire Line
	5250 1100 4950 1100
$Comp
L Device:D D3
U 1 1 5E627BD9
P 5400 1100
F 0 "D3" H 5400 1316 50  0000 C CNN
F 1 "D" H 5400 1225 50  0000 C CNN
F 2 "Diode_SMD:D_SMA" H 5400 1100 50  0001 C CNN
F 3 "~" H 5400 1100 50  0001 C CNN
	1    5400 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 1600 5850 1600
Wire Wire Line
	4700 1600 4950 1600
$Comp
L power:+12V #PWR010
U 1 1 5E60E8A6
P 4700 1600
F 0 "#PWR010" H 4700 1450 50  0001 C CNN
F 1 "+12V" H 4715 1773 50  0000 C CNN
F 2 "" H 4700 1600 50  0001 C CNN
F 3 "" H 4700 1600 50  0001 C CNN
	1    4700 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	5900 2500 5900 2100
Connection ~ 5900 2500
Wire Wire Line
	5700 2500 5900 2500
Wire Wire Line
	5900 2100 5700 2100
Wire Wire Line
	5900 2900 5900 2500
Wire Wire Line
	1800 2900 5900 2900
$Comp
L precharge-library:GLV+ #PWR013
U 1 1 5E5E8119
P 5100 2400
F 0 "#PWR013" H 5100 2250 50  0001 C CNN
F 1 "GLV+" H 5115 2573 50  0000 C CNN
F 2 "" H 5100 2400 50  0001 C CNN
F 3 "" H 5100 2400 50  0001 C CNN
	1    5100 2400
	0    -1   -1   0   
$EndComp
$Comp
L precharge-library:GLV+ #PWR012
U 1 1 5E5E7AE0
P 5100 2000
F 0 "#PWR012" H 5100 1850 50  0001 C CNN
F 1 "GLV+" H 5115 2173 50  0000 C CNN
F 2 "" H 5100 2000 50  0001 C CNN
F 3 "" H 5100 2000 50  0001 C CNN
	1    5100 2000
	0    -1   -1   0   
$EndComp
$Comp
L precharge-library:OMRON-G2R-24 K1
U 1 1 5E5DE7BD
P 5400 2000
F 0 "K1" V 4633 2000 50  0000 C CNN
F 1 "OMRON-G2R-24" V 4724 2000 50  0000 C CNN
F 2 "Precharge:OMRON-G2R-24" H 5400 2000 50  0001 C CNN
F 3 "" H 5400 2000 50  0001 C CNN
	1    5400 2000
	0    1    1    0   
$EndComp
Wire Wire Line
	13850 6250 13850 7850
Wire Wire Line
	13700 6250 13850 6250
Text Label 12450 7150 0    50   ~ 0
HV_IN
Text Label 12450 6600 0    50   ~ 0
HV_OUT
Text Label 11700 6600 0    50   ~ 0
V_TS
Wire Wire Line
	4550 8050 13000 8050
$Comp
L Device:R R6
U 1 1 5E608B0E
P 6450 1950
F 0 "R6" V 6243 1950 50  0000 C CNN
F 1 "10k" V 6334 1950 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 6380 1950 50  0001 C CNN
F 3 "~" H 6450 1950 50  0001 C CNN
	1    6450 1950
	0    -1   -1   0   
$EndComp
$Comp
L precharge-library:GLV- #PWR014
U 1 1 5E608B15
P 6750 1600
F 0 "#PWR014" H 6750 1450 50  0001 C CNN
F 1 "GLV-" H 6765 1773 50  0000 C CNN
F 2 "" H 6750 1600 50  0001 C CNN
F 3 "" H 6750 1600 50  0001 C CNN
	1    6750 1600
	0    1    1    0   
$EndComp
$Comp
L Transistor_FET:2N7002 Q1
U 1 1 5E608B1B
P 6300 1700
F 0 "Q1" H 6506 1746 50  0000 L CNN
F 1 "2N7002" H 6506 1655 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 6500 1625 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N7002.pdf" H 6300 1700 50  0001 L CNN
	1    6300 1700
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R5
U 1 1 5E6179B8
P 6300 2250
F 0 "R5" V 6093 2250 50  0000 C CNN
F 1 "220" V 6184 2250 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 6230 2250 50  0001 C CNN
F 3 "~" H 6300 2250 50  0001 C CNN
	1    6300 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	6300 2400 6300 8150
Wire Wire Line
	6300 1900 6300 1950
Connection ~ 6300 1950
Wire Wire Line
	6300 1950 6300 2100
Wire Wire Line
	6600 1950 6600 1600
Wire Wire Line
	6500 1600 6600 1600
Connection ~ 6600 1600
Wire Wire Line
	6600 1600 6750 1600
$Comp
L Connector:Conn_01x02_Female J4
U 1 1 5E7F2E45
P 12200 6200
F 0 "J4" V 12138 6012 50  0000 R CNN
F 1 "R_PRECHG" V 12047 6012 50  0000 R CNN
F 2 "Connector_Molex:Molex_Mini-Fit_Jr_5566-02A_2x01_P4.20mm_Vertical" H 12200 6200 50  0001 C CNN
F 3 "~" H 12200 6200 50  0001 C CNN
	1    12200 6200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	12300 6600 12300 6400
Wire Wire Line
	12300 6600 13000 6600
Wire Wire Line
	12200 6400 12200 6600
Wire Wire Line
	11600 6600 12200 6600
$Comp
L Connector:Conn_01x02_Female J3
U 1 1 5E7FDE53
P 11250 6900
F 0 "J3" H 11142 6575 50  0000 C CNN
F 1 "HV" H 11142 6666 50  0000 C CNN
F 2 "Connector_Molex:Molex_Mini-Fit_Jr_5566-02A_2x01_P4.20mm_Vertical" H 11250 6900 50  0001 C CNN
F 3 "~" H 11250 6900 50  0001 C CNN
	1    11250 6900
	-1   0    0    1   
$EndComp
Wire Wire Line
	11450 6800 11600 6800
Wire Wire Line
	11600 6800 11600 6600
Wire Wire Line
	11450 6900 11600 6900
Wire Wire Line
	11600 6900 11600 7150
Wire Wire Line
	11600 7150 13000 7150
$Comp
L Regulator_Linear:AMS1117-5.0 U1
U 1 1 5E8177C7
P 3950 1550
F 0 "U1" H 3950 1792 50  0000 C CNN
F 1 "AMS1117-5.0" H 3950 1701 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 3950 1750 50  0001 C CNN
F 3 "http://www.advanced-monolithic.com/pdf/ds1117.pdf" H 4050 1300 50  0001 C CNN
	1    3950 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 8150 6300 8150
Text Label 4700 8150 0    50   ~ 0
SHTDN_CTRL
Wire Wire Line
	4250 1550 4400 1550
$Comp
L Device:C C7
U 1 1 5E8673AD
P 3550 7300
F 0 "C7" H 3665 7346 50  0000 L CNN
F 1 "100n" H 3665 7255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 3588 7150 50  0001 C CNN
F 3 "~" H 3550 7300 50  0001 C CNN
	1    3550 7300
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3700 7300 3950 7300
Connection ~ 3950 7300
Wire Wire Line
	3950 7300 3950 7100
$Comp
L precharge-library:GLV- #PWR0101
U 1 1 5E871E1B
P 3200 7300
F 0 "#PWR0101" H 3200 7150 50  0001 C CNN
F 1 "GLV-" H 3215 7473 50  0000 C CNN
F 2 "" H 3200 7300 50  0001 C CNN
F 3 "" H 3200 7300 50  0001 C CNN
	1    3200 7300
	-1   0    0    1   
$EndComp
Wire Wire Line
	3200 7300 3400 7300
Text Notes 10400 6150 0    50   ~ 0
Resistor\nTHS50180RJ\nRated to sustain 20x overload for 1 second\n\nLoad profile for 400VDC, 1600uF total (refer to spice sims):\n0.0s: 18x overload\n0.2s:  5x overload
$Comp
L precharge-library:GLV+ #PWR0102
U 1 1 5E88397C
P 6750 9250
F 0 "#PWR0102" H 6750 9100 50  0001 C CNN
F 1 "GLV+" H 6765 9423 50  0000 C CNN
F 2 "" H 6750 9250 50  0001 C CNN
F 3 "" H 6750 9250 50  0001 C CNN
	1    6750 9250
	1    0    0    -1  
$EndComp
$Comp
L Device:D D5
U 1 1 5E8855EB
P 5200 8700
F 0 "D5" H 5200 8484 50  0000 C CNN
F 1 "D" H 5200 8575 50  0000 C CNN
F 2 "Diode_SMD:D_SMA" H 5200 8700 50  0001 C CNN
F 3 "~" H 5200 8700 50  0001 C CNN
	1    5200 8700
	0    1    -1   0   
$EndComp
Wire Wire Line
	4800 8250 5200 8250
$Comp
L Device:R R13
U 1 1 5E89F0C8
P 5200 8400
F 0 "R13" V 4993 8400 50  0000 C CNN
F 1 "100" V 5084 8400 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 5130 8400 50  0001 C CNN
F 3 "~" H 5200 8400 50  0001 C CNN
	1    5200 8400
	1    0    0    -1  
$EndComp
Connection ~ 5200 8250
Wire Wire Line
	5200 8250 5350 8250
$Comp
L Device:R R16
U 1 1 5E8AA73B
P 6750 9700
F 0 "R16" V 6543 9700 50  0000 C CNN
F 1 "10k" V 6634 9700 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 6680 9700 50  0001 C CNN
F 3 "~" H 6750 9700 50  0001 C CNN
	1    6750 9700
	1    0    0    -1  
$EndComp
$Comp
L Device:R R17
U 1 1 5E8B1438
P 6750 10500
F 0 "R17" V 6543 10500 50  0000 C CNN
F 1 "10k" V 6634 10500 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 6680 10500 50  0001 C CNN
F 3 "~" H 6750 10500 50  0001 C CNN
	1    6750 10500
	1    0    0    -1  
$EndComp
$Comp
L precharge-library:GLV- #PWR0103
U 1 1 5E8B1DD5
P 6750 10700
F 0 "#PWR0103" H 6750 10550 50  0001 C CNN
F 1 "GLV-" H 6765 10873 50  0000 C CNN
F 2 "" H 6750 10700 50  0001 C CNN
F 3 "" H 6750 10700 50  0001 C CNN
	1    6750 10700
	-1   0    0    1   
$EndComp
Wire Wire Line
	6750 10700 6750 10650
Wire Wire Line
	5800 9950 6750 9950
Wire Wire Line
	6750 9950 6750 9850
Wire Wire Line
	6750 9950 6750 10350
Connection ~ 6750 9950
$Comp
L power:+5V #PWR0104
U 1 1 5E8CB642
P 6100 9550
F 0 "#PWR0104" H 6100 9400 50  0001 C CNN
F 1 "+5V" H 6115 9723 50  0000 C CNN
F 2 "" H 6100 9550 50  0001 C CNN
F 3 "" H 6100 9550 50  0001 C CNN
	1    6100 9550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R14
U 1 1 5E8CC1FA
P 6100 9700
F 0 "R14" V 5893 9700 50  0000 C CNN
F 1 "10k" V 5984 9700 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 6030 9700 50  0001 C CNN
F 3 "~" H 6100 9700 50  0001 C CNN
	1    6100 9700
	1    0    0    -1  
$EndComp
$Comp
L Device:R R15
U 1 1 5E8CC57D
P 6100 10500
F 0 "R15" V 5893 10500 50  0000 C CNN
F 1 "10k" V 5984 10500 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 6030 10500 50  0001 C CNN
F 3 "~" H 6100 10500 50  0001 C CNN
	1    6100 10500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 10650 6100 10700
Wire Wire Line
	6100 10700 6750 10700
Connection ~ 6750 10700
Wire Wire Line
	6100 10350 6100 10150
Wire Wire Line
	5800 10150 6100 10150
Connection ~ 6100 10150
Wire Wire Line
	6100 10150 6100 9850
$Comp
L Device:D D6
U 1 1 5E8E0179
P 6750 9400
F 0 "D6" H 6750 9184 50  0000 C CNN
F 1 "D" H 6750 9275 50  0000 C CNN
F 2 "Diode_SMD:D_SMA" H 6750 9400 50  0001 C CNN
F 3 "~" H 6750 9400 50  0001 C CNN
	1    6750 9400
	0    -1   -1   0   
$EndComp
$Comp
L Device:C C8
U 1 1 5E902305
P 7000 10500
F 0 "C8" H 7115 10546 50  0000 L CNN
F 1 "100n" H 7115 10455 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 7038 10350 50  0001 C CNN
F 3 "~" H 7000 10500 50  0001 C CNN
	1    7000 10500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6750 10700 7000 10700
Wire Wire Line
	7000 10700 7000 10650
Wire Wire Line
	7000 10350 7000 9950
Wire Wire Line
	7000 9950 6750 9950
Wire Wire Line
	5200 8850 5200 10050
Wire Notes Line
	7450 11000 7450 9000
Wire Notes Line
	7450 9000 5050 9000
Wire Notes Line
	5050 9000 5050 11000
Wire Notes Line
	5050 11000 7450 11000
Text Notes 6100 9000 0    50   ~ 0
Reset controller if GLV sags. \nPrevent chatter in shutdown circuit
$Comp
L Comparator:MCP6562 U3
U 2 1 5E954F99
P 5500 10050
F 0 "U3" H 5500 10417 50  0000 C CNN
F 1 "MCP6562" H 5500 10326 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 5500 10050 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/22139C.pdf" H 5500 10050 50  0001 C CNN
	2    5500 10050
	-1   0    0    -1  
$EndComp
$EndSCHEMATC