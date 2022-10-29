# Task 1
## Objectives

By the end of this experiment, you should be able to:

- write a basic System Verilog specification for a memory component
- pre-load the memory with known contents stored in an initialization file
- design a signal generator by combining a counter with a ROM component
- change the frequency of the signal with rotary encoder on Vbuddy
- generate two sinusoidal signals simultaneously with different phases using dual-port ROM
- capture and store a audio signal using the microphone on Vbuddy and a RAM component
- read and write to a RAM component simultaneously
- use parameterisation to generalise designs for different address or data widths

## STEP 1

For the first step I specified a 256 x 8 bit ROM, writing the system verlilog code to input sinwave values into a ROM with an address width of 8 and 256 address inputs.
Within VS code I already had the code to generate 256 sine wave values, written in python:

<img width="510" alt="Screenshot 2022-10-27 at 10 30 10" src="https://user-images.githubusercontent.com/115703122/198248034-6c74f4d6-2ae3-4374-99cb-6d44bdb8d34c.png">

OUTPUT: sinerom.mem

<img width="412" alt="Screenshot 2022-10-27 at 10 30 30" src="https://user-images.githubusercontent.com/115703122/198248122-ef965abc-03a1-4253-846b-b0d16f5930bf.png">

The ROM needs to be configured with original contents.  In SystemVerilog, the  $readmemh(.) function allows the ROM to be loaded with the contents stored in a file with numbers stored as hexadecimal.
The sinerom.mem file contains 256 samples of a single cycle cosine values with a number ranging from 8’h00 to 8’hFF. Sinerom.mem is generated with a simple Python script shown here.  


<img width="753" alt="Screenshot 2022-10-27 at 10 34 23" src="https://user-images.githubusercontent.com/115703122/198248955-95b8e4c0-3dd8-4768-b2c4-9ec8af9d59a3.png">

I then created a file create the component rom.sv. We specify it behaviourally.  This allows digital system to be modelled, simulated and verified. Memory cells are synthesized into D-FF, and are large and expensive in resources.
Shown here is a 256 x 8 bit ROM model in SystemVerilog. This is specified as a synchronous ROM.  The ROM output data only appears on  dout on positive edge of clk.  Here we also omit the output enable (OE) control signal.

<img width="268" alt="Screenshot 2022-10-27 at 10 37 37" src="https://user-images.githubusercontent.com/115703122/198249697-29794a81-0182-4e80-9a8f-b2f7a67652ed.png"> 
<img width="582" alt="Screenshot 2022-10-27 at 10 38 05" src="https://user-images.githubusercontent.com/115703122/198249817-5d07e0db-acce-4ea6-a841-e9f4020e4847.png">

## STEP 2 

 Next we create the sinegen module: This requires you to create a "top-level" module sinegen.sv, which includes two components: counter.sv and rom.sv as shown below.
 
 <img width="563" alt="Screenshot 2022-10-27 at 10 40 14" src="https://user-images.githubusercontent.com/115703122/198250348-1ddf0b87-3232-4159-ad1a-8c85418c0ffa.png">

A simple sinewave generator can be designed with combining  counter.sv and rom.sv.  The counter produces the address of the ROM, and the output is the sine (or cosine) values.  The frequency of the output sinewave is determined by incr[7:0].  If incr = 1, then the sinewave period is 256 x clock period.  In general, the output sinewave frequency is:

<img width="261" alt="Screenshot 2022-10-27 at 11 02 45" src="https://user-images.githubusercontent.com/115703122/198255629-04465f5e-c66f-4df6-98f1-de633f0aba75.png">

The increment works, as taking the sine generated values but in a shorter time period, as it can go through the loop of values faster producing more waves in a given time frame. 

<img width="452" alt="Screenshot 2022-10-28 at 10 27 53" src="https://user-images.githubusercontent.com/115703122/198554260-232f3097-8fc9-4420-8691-6c30eac46024.png">

We then edited the counter.sv to now count up by increment. I also removed the reset from always ff as this is a sychronous clock. Finally I added the 8 bit increatment as an input. This implemented the increment function within counter.   

<img width="413" alt="Screenshot 2022-10-28 at 10 42 17" src="https://user-images.githubusercontent.com/115703122/198557312-f5975f0a-6ab4-483c-bd28-b190f7542ac8.png">

## STEP 3

Create the testbench for sinegen:

<img width="542" alt="Screenshot 2022-10-28 at 10 32 17" src="https://user-images.githubusercontent.com/115703122/198555184-62a6be94-809a-4abe-900c-48223e57e897.png">


Here are two things you should do:

Since you are generating a continuous sinewave, the number of simulation cycle should be increased to a large value, say, 1,000,000!
Because of this large number of simulation cycles before termination, you need to have an elegant way to exit the simulation. Use the vbdGetkey() function to check if a key has been pressed. This can be achieved with the following code snippet to exit the simulation any time you press the 'q' key:


## STEP 4

Modify the shell script doit.sh:

<img width="591" alt="Screenshot 2022-10-28 at 10 49 01" src="https://user-images.githubusercontent.com/115703122/198558655-ae702857-7ae9-429a-96c3-cf3f0817cbcf.png">

OUTPUT:

<img width="698" alt="Screenshot 2022-10-29 at 02 08 36" src="https://user-images.githubusercontent.com/115703122/198755021-9a6078e2-522c-4c43-8158-c006d65a8dca.png">





