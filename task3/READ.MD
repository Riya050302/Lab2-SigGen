# Task 3

- The goal of Task 3 is to capture real audio signal using the microphone/amplifier module on Vbuddy. 
- These samples are written to a dual-port RAM stored in successive locations.
-  At the same time, read back from the RAM the store signal at a different address offset from the write address. 
 - The retrieved signal is a delayed version of the original signal.

Capturing audio signal from Vbuddy requires two steps:

- Use the vbdInitMicIn() function to inform Vbuddy the size of audio signal buffer to reserve for storing the captured sample.
- Use the vbdMicValue() function to return the next sample in the audio buffer. When all the samples are exhausted, Vbuddy will automatically capture another block of audio samples and store them in the audio buffer.

<img width="444" alt="Screenshot 2022-10-29 at 02 00 46" src="https://user-images.githubusercontent.com/115703122/198754732-9237a694-40c4-4483-acaa-177fed11b04c.png">

In order to perform the task i need to change the Rom to a  a 512 x 8 bit dual-port RAM component. This meant changing the parameter within count.sv and the address_width with the ram to 9 insted of 8. 

<img width="362" alt="Screenshot 2022-10-29 at 01 41 44" src="https://user-images.githubusercontent.com/115703122/198753919-9bdf7667-9907-4987-888f-37485e631de3.png">

Next, I had to create a raam2port.sv file. The inclued an input of a read, write and their respective enables. This also had a clock with data in and data out. 
- If write is enabled then data in will be written into address wrtadrress. 
- If the read is enabled the ram will read the read address, called dout.
<img width="341" alt="Screenshot 2022-10-29 at 01 47 41" src="https://user-images.githubusercontent.com/115703122/198754203-f455d3d5-0ca4-4022-ae99-c2a08cbf39f4.png">
<img width="474" alt="Screenshot 2022-10-29 at 01 47 22" src="https://user-images.githubusercontent.com/115703122/198754178-9ecf9162-0065-441c-8d28-4fa4f4deb484.png">

Then, I combined the dual-port RAM with the counter to form a top-level module called sigdelay.sv. I added an input offset which could then be used to offset (phase shift the write from the read by a difference of vbdValue()).
The difference between the read and write addresses is the offset. Use the vbdValue() function to vary this offset using the rotary encoder. 
The data is counted within the counter module and then stored with signal delay between read and write through ram2port producing two waves with phase shift of offset.

<img width="548" alt="Screenshot 2022-10-29 at 01 53 12" src="https://user-images.githubusercontent.com/115703122/198754413-44c0a8b1-f1bf-40a4-b8ad-9dd1dd6ed270.png">

Finally, I implemented the testbench:

<img width="465" alt="Screenshot 2022-10-29 at 01 55 51" src="https://user-images.githubusercontent.com/115703122/198754519-362065f0-64fb-40e9-b616-09b06cb32c4c.png">

I changed the inputs of the testbench to include wr_en and rd_en and counter inputs. You don't include the write address and read as they are from the innerconnected wire and not an overall input. Offset is initalised on 64 (90 degrees).

<img width="160" alt="Screenshot 2022-10-29 at 01 58 56" src="https://user-images.githubusercontent.com/115703122/198754651-d7e53385-3de3-4f22-b0b1-ff5820b7c2ae.png">

Next, I sent the data input to the Mic input and the offset to vbdValue().

<img width="364" alt="Screenshot 2022-10-29 at 02 00 13" src="https://user-images.githubusercontent.com/115703122/198754708-708ff393-ff57-4386-b746-1299c4a209bc.png">

Finally, I used the vbdValue() function to vary this offset using the rotary encoder, plotting both the write and read data on the Vbuddy display (using vbdPlot() function). This meant that it plots data that has been read as well as plotting the same graph now with a phase shift of vdbvalue written onto it. 
<img width="448" alt="Screenshot 2022-10-29 at 02 03 33" src="https://user-images.githubusercontent.com/115703122/198754820-888f5311-a033-450a-9468-c7a43daa1f9c.png">

OUTPUT IMAGE:


