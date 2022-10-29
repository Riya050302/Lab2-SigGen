# Task 2 

Modify your design in Task 1 so that you generate TWO simultaenous sinusoid signals which have different phases. The phase offset between the two sinusoids is determined by the rotary encoder on Vbuddy. You need to use a dual-port ROM similar to that you used in Task 1. The first port's address addr1[7:0] is from the counter. The second port's address addr2]7:0] is offset from the first address. This offset is read from Vbuddy with the vbdValue() function.

In order to implement two wave outputs we had to craete a dual port rom:

<img width="305" alt="Screenshot 2022-10-28 at 11 28 12" src="https://user-images.githubusercontent.com/115703122/198566300-3cc8dd6d-4acb-4b55-9d02-3d25b37227e2.png">

The new rom.sv code, included a new address and output, this allows you to do two operations simultenously to the same memory. 

<img width="410" alt="Screenshot 2022-10-28 at 11 29 09" src="https://user-images.githubusercontent.com/115703122/198566508-40de535a-48bb-4585-8ff0-eda2619625e6.png">

I then changed then singen.sv file to include the additional address and ouput by taking the address from counter and inputting it to two different addresses.

<img width="192" alt="Screenshot 2022-10-28 at 11 32 23" src="https://user-images.githubusercontent.com/115703122/198567141-bc4d69ad-04d0-49c4-ab2b-1deb9fe696f0.png">

I added an additional VbdPlot() function to plot both outputs:

<img width="308" alt="Screenshot 2022-10-28 at 11 33 13" src="https://user-images.githubusercontent.com/115703122/198567297-8bf958be-6e96-4514-ac7a-51989dd95e48.png">

My first attempt to pahse shift was changing the output by 90 degrees howver instead of shifting right this shifted upwards:

<img width="461" alt="Screenshot 2022-10-28 at 11 33 59" src="https://user-images.githubusercontent.com/115703122/198567451-a50dd1af-f61a-4124-b8f5-08d7443db702.png">

The correct approach was two offset within rom.sv as this worked to offset the address input by 90 degrees:

<img width="434" alt="Screenshot 2022-10-28 at 11 34 46" src="https://user-images.githubusercontent.com/115703122/198567584-6d589a03-4e96-4b98-9cfe-b1dd6bf690d8.png">

In order to set the phase shift to VbdValue():

We couldn't call VbdValue() as the cpp is the executable file. Instead in order to change the address I set the address offset to increment and then with the test bench function I set incr = VbdValue(), within sinegen.sv

<img width="313" alt="Screenshot 2022-10-29 at 02 06 55" src="https://user-images.githubusercontent.com/115703122/198754956-c58ebf2d-9d0f-4f39-977b-34b7962c0e06.png">

As the graph was changing increment and offset, I changed the counter.sv to increment by a constant 3 instead:

<img width="373" alt="Screenshot 2022-10-28 at 11 52 18" src="https://user-images.githubusercontent.com/115703122/198570616-dd25f21e-6f3b-4beb-aa38-9b96ffd4688a.png">





