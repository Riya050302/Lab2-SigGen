# Task 2 

Modify your design in Task 1 so that you generate TWO simultaenous sinusoid signals which have different phases. The phase offset between the two sinusoids is determined by the rotary encoder on Vbuddy. You need to use a dual-port ROM similar to that you used in Task 1. The first port's address addr1[7:0] is from the counter. The second port's address addr2]7:0] is offset from the first address. This offset is read from Vbuddy with the vbdValue() function.

