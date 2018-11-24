# Digital-Timer-on-8051
## General Information

The goal of this project is to give you a complete experience in design and programming of an 8051 microcon- troller system that controls various input/output devices and possibly communicates with other softwares. 

## System Specification

We want to develop a digital timer using virtual hardwares wuth MCU 8051 IDE. Due to the speed of simulation, a time unit is defined to be 1 ms/milliseconds in the simulator. 

**Hardware**: The virtual hardwares for a 8 × 8 LED matrix and a 4 × 4 keypad are provided. Please load the virtual hardwares to see the actual pin connections. You may use another virtual hardware available to construct your extra functions. 
You can assume the MCU is clocked at 10 MHz so you can put 10000 to the clock frequency in your simulator. 

**Software**: The specification and basic functions of the timer are: 
- switch between the preset mode and countdown mode using the HASH key; 
- in preset mode, the countdown time can be entered using the keypad (0-9);  You can assume the maximum time is 99 units. 
- in countdown mode, the timer is started(and paused) using the STAR (∗) key and can be resetted back to the preset time by the ZERO (0) key; 
- the time (in both modes) should be displayed on the LED matrix display in an appropriate format that is easy to read and understand. 
- when time is up, there should be a visual signal (e.g. flashing of zeros) for at least 5 units of time. 

Your main task in this project is to program the digital timer using assembly language. Also you may want to add some advanced / innovation features to your meter as explained below: 

**Advanced/Innovative Features**: The above describes only the basic functions of the digital timer. You are recommended to think of 1-2 useful additional functions innovatively and implement them in your 8051 program. You can use any other virtual hardware for your additional functions. 

