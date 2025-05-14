# **Card Memory Game**

This lab utilizes the Nexys A7-100T FPGA board coded with VHDL to create a card matching memory game displayed via the VGA connection on the board built off of the Lab 3 ball project

- The necessary components to use this project are the **Nexys A7-100t**, and a way of connecting the boards female **VGA connector** to a display, whether that is a VGA to VGA connectoror it involves a HDMI to VGA adapter.

![VGA cable](https://github.com/user-attachments/assets/b39fe03f-0e09-4978-b40c-8f000f6219b9)

- The code only uses three color bits being the most significant bits of the red, green, blue bits.

- This project creates twelve red "face down" cards in a 3x4 grid on a screen of size 800x600 with a white background. Using the onboard switches, the user will attempt to select two of the same color card in succession. There will be 6 different pairs of cards "face up" being cyan, blue, magenta, green, yellow, and black. Once a pair is successfully selected in succession, they will stay "face up" until every card is "face up." Each card is mapped to one of 12 switches on the board and the 16th switch is used as a reset switch to flip every card "face down" and restart. There is a "phase" indicator in the bottom right which will be black when the first card is being chosen then red with the second card. If two cards are selected that aren't a match, then they will get flipped back down.

- The top of the hierarchy is the **vga_top** module which contains all of the board inputs which are mapped throughout the project **card** and **vga_sync** modules, and the logic used to flip the cards using the onboard switches.

   - The logic for the switches uses a switch case statement which only allows one switch to be flipped at a time to avoid confusion.
   - This was originally a file in Lab 3 which was modified to contain new signals for the card_flip and the card x and y positions as well as to use the aformentioned switch case statement
 
- The **card** module creates the actual cards that will be displayed using carddraw 1 -> C processes then runs the game logic in 2 individual processes (one to determine whether the 1st or 2nd card is being picked, and another for all the logic of the game) and finally handles the coloring in a new Color process
  
![Blank Canvas](https://github.com/user-attachments/assets/4d053dd5-cf3c-408f-86ce-021652bcf9d7)

  - The card module starts by taking all the various inputs from vga_top to start making a basis for the game, even before any logic of playing the game takes place, like the x and y coordinates to each card, syncronization variables, and active inputs from the player that go through vga_top such as a "hit" variable which detects when any input is "hit" in, and a "RESET" variable too, which is activated when we flip the 15th switch (or the first one if you look left right), the pixel row and column the VGA section is currently on (used later for visual display), and all the flip signals which tell the code what card the player has chosen to flip over.
  - The only output or exports of card.vhd is the red green and blue values for the VGA display, which logic is gotten into later when displaying the cards
  - After setting up the input and outputs of the program, first thing the program is doing, is creating a whole bunch of signals that are going to be used in the program for holding various signals, such as "card_on" 1 -> C which is used for the VGA display to know when the current pixel is on a position meant for a card, "card_lock" 1 -> C signals which will be on when the card is supposed to be showing, off when its not. "Game_complete" 1->6 signals which will turn on when a respected pair of cards is discovered, a "flip" signal which goes from 0 to 1 to 0 to 1... on each rising edge of an input going in/just turning a switch on. And finally there is a test signal included which will end up drawing a card in the bottom right corner of the screen which displays black if picking your first card, and red if picking your second one. 
  - After setting up the signal comes card location logic, using the card_on 1->C signals, 12 different carddraw processes run to determine where the cards locations are, by using if/else statements with a logic checking if the current coordinate position is within the boundary of the size integer away in the pos/neg direction from the cards center in both x and y axis (the same from the ball lab when it was a square), and if it is, the card on variable is turned on
  - After comes the actual game, first process just determies which card is being picked using a "flip" variable which starts at 0. The process waits till the rising edge of the "hit" variable, which is the variable that is on when a switch is on, so it detects any input. When the process activates, it flips the value of "flip" (uses a not gate process), where "flip" starts at 0, so when you intitially put an input in, it goes to 1, and then the game uses the logic of what card is activated to do its logic. turn off the switch and turn on the second choice card switch and it will revert back to a zero and the chosen switch will be used in the second part of the game logic for the second card
  - For the main process, the game process runs with the vga_sync clock, starts off by individually checking each "game_complete" variable to see if any pairs have been found, to which if they were, their respective cards would be "locked" or turned over and shown. Then it checks if the reset is activated, if it has, all variables would be reset to zero, and the code would run as if you had started the game over from the beginning. Next is the fail check, which checks if the player failed in picking the right two cards, and if it has, the code will unlock, or hide every card uponthe "fail" signal being 1, and the sets the sigal back to 0 at the end of hiding all the cards. This is counterracted by the game_complete logic, as every card is flipped o be hidden, but not the game_complete variables or known knowledge of card pairs being found, so it would just re-reveal the cards you've already found.
  - After those three is the real logic, which all starts on an elsif statement if the "hit" variable is 1, or a switch input has been given. Then there are two branches, one for if its the first card pick, and another for second card pick. First cardpick happens when the "flip" variable is 1, which it will be upon first input, and it locks the card choses by the input, as chosen by the "flip_card" variable in vga_top, and will only turn on the lock for a card that isnt already locked to prevent issues.
  - When you're ready for youre second input,pull back the first switch and flip on the second choice switch, where now the "flip" variable will go to 0, and activate the second card choice logic using your second input, where it first does the same thing as not working with already locked cards, second checks if its pair card is locked/showing, where if it isnt, the "fail" variable is set to one, and the process goes back to the beginning, but if its pair card is showing, then the second card selected choice will lock, and the game_complete variable for the two cards will go to 1, signifying the pair has been found, and then the whole process repeats over 
  - After all the game process comes to display the actual cards, which is very simple. Using if and elsif statements, if "card_on"1-> is on or 1, then that card will be drawn for that pixel, and since card_on is on for all pixels of the card due to the barrier if logic used both in lab 3 and this project, each card_on will be activated for their respective card locations. After checking if the current pixel of the display is on a card, it will check if that card is locked or not. If its not locked (hidden) it draws a red pixel, which will make a red card (hidden card), and if its not locked (revealed), it will display the cards true colors, all done by assigning values to "red", "blue", and "green" variables. If the current pixel is not on any card, it will display a combination of red/green/blue which might be white, but on a screen looks like a darker green. Since three colors are used to make the color of a pixel, we have 8 total colors to work with, 1 color for the background, 1 color for the hidden cards, 6 colors would be used for 6 pairs
- **MODIFICATIONS:**
  - The lab takes inspiration from lab 3, mainly the VGA display, where we used the same general process for drawing our components (one component has all parts and uses a "on pixel A" variable to determine whether or not to update the color of the output pixel its currently on or not). The things we changed/added was removing the logic for making an object move around the screen by modifying its center position, and implementing the same boundary logic for our boundaries for our objects, and also implementing new code to have our card game play, and determine what color is going to be displayed for the cards. On top of all that, we just made all the shapes we wanted, squares for cards, and chose colors for them, and for them to be updated upon uses of the switches.

 - The **vga_sync** module handles the utilization of the VGA displaying by using a clock to drive horizontal and vertical counters

   - These counters are then used to generate the various timing signals.
   - The vertical and horizontal sync waveforms, vsync and hsync, will go directly to the VGA display with the column and row address, pixel_col and pixel_row, of the current pixel being displayed.
   - This module also takes as input the current red, green, and blue video data and gates it with a signal called video_on.
   - This ensures that no video is sent to the display during the sync and blanking periods.
   - Note that red, green, and blue video are each represented as 1-bit (on-off) quantities
   - This file is unchanged from Lab 3


- The two **clk_wiz** files handle the clock signals that are used in the project and were taken from Lab 3 as well

- The **card_memory** constraint file contains the 100MHz clock signal, vga connections, and all of the board switches

  
### 1. Create a new RTL project vgaball in Vivado Quick Start

- Create five new source files of file type VHDL called clk_wiz_0, clk_wiz_0_clk_wiz, vga_sync, card, and vga_top

- Create a new constraint file of file type XDC called card_memory

- Choose Nexys A7-100T board for the project

- Click 'Finish'

- Click design sources and copy the VHDL code from clk_wiz_0.vhd, clk_wiz_0_clk_wiz.vhd, vga_sync.vhd, card.vhd, and vga_top.vhd

- Click constraints and copy the code from card_memory.xdc

- As an alternative, you can instead download files from Github and import them into your project when creating the project. The source file or files would still be imported during the Source step, and the constraint file or files would still be imported during the Constraints step.

### 2. Run synthesis
### 3. Run implementation
### 3b. (optional, generally not recommended as it is difficult to extract information from and can cause Vivado shutdown) Open implemented design
### 4. Generate bitstream, open hardware manager, and program device

- Click 'Generate Bitstream'

- Click 'Open Hardware Manager' and click 'Open Target' then 'Auto Connect'

- Click 'Program Device' then xc7a100t_0 to download vga_top.bit to the Nexys A7 board

