# VHDL-CLOCKsevenseg
My system will implement a stopwatch that also operates as a clock. 
There are three modes within this system, Clock Mode, Clock-Setup Mode, and Stopwatch Mode. 
This system uses a keypad to specify the modes and to manipulate each.
The seven segment display is used to display the current time in each mode. 
Clock mode is the basis mode of the system, will start off displaying 12pm and will increment every minute. 
To differentiate between AM and PM, the clock will be in military time.
	In order to access Clock-Setup Mode, the user must press button 1. 
  In this mode, the clock can be incremented by pressing button 2 and decremented by pressing button 3.
  In order to specify which digit is being manipulated, the user must use the digit switches (3 downto 0) and then press either button 2 or 3.
  Once the value is set to that specific digit, the user must press 0. In order to return to clock mode, the user must press button 4. 
  In order to transition to stopwatch mode, the user must press button 5. Clock mode is updated by Clock-Setup mode’s output and operates as a normal clock.
	In order to access Stopwatch mode, the user must press button 5.
  Once in this mode the user must press button 2 to start the stopwatch. 
  If the user wishes to pause the stopwatch, they must press button 3. 
  To reset the stopwatch the user must access a different mode and return to stopwatch mode.
  Each mode is accessible from any other mode. 

VIDEO DEMO
https://youtu.be/TYuSvWG1tn4
