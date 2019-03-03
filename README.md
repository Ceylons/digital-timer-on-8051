# Digital-Timer-on-8051

## System Specification

Develop a digital timer using virtual hardwares with MCU 8051 IDE. Due to the speed of simulation, a time unit is defined to be 1 ms/milliseconds in the simulator. 

**Hardware**: A 8 × 8 LED matrix and a 4 × 4 keypad. Assume the MCU is clocked at 10 MHz.

**Software**: The basic functions of the timer are: 
- switch between the preset mode and countdown mode using the HASH key; 
- in preset mode, the countdown time can be entered using the keypad (0-9); Assume the maximum time is 99 units. 
- in countdown mode, the timer is started(and paused) using the STAR (∗) key and can be resetted back to the preset time by the ZERO (0) key; 
- the time (in both modes) should be displayed on the LED matrix display in an appropriate format that is easy to read and understand. 
- when time is up, there should be a visual signal (flashing of zeros) for at least 5 units of time. 

## Usage

Import three .vhc files and run main.asm

