# **Card Memory Game**

This lab utilizes the Nexys A7-100T FPGA board coded with VHDL to create a card matching memory game displayed via the VGA connection on the board built off of the Lab 3 ball project

- The necessary components to use this project are the **Nexys A7-100t**, and a way of connecting the boards female **VGA connector** to a display, whether that is a VGA to VGA connectoror it involves a HDMI to VGA adapter.

![VGA cable](https://github.com/user-attachments/assets/b39fe03f-0e09-4978-b40c-8f000f6219b9)

- The code only uses three color bits being the most significant bits of the red, green, blue bits.

- This project creates twelve red "face down" cards in a 3x4 grid on a screen of size 800x600 with a white background. Using the onboard switches, the user will attempt to select two of the same color card in succession. There will be 6 different pairs of cards "face up" being cyan, blue, magenta, green, yellow, and black. Once a pair is successfully selected in succession, they will stay "face up" until every card is "face up." Each card is mapped to one of 12 switches on the board and the 16th switch is used as a reset switch to flip every card "face down" and restart. There is a "phase" indicator in the bottom right which will be black when the first card is being chosen then red with the second card. If two cards are selected that aren't a match, then they will get flipped back down.

- The top of the hierarchy is the **vga_top** module which contains all of the board inputs which are mapped throughout the project **card** and **vga_sync** modules, and the logic used to flip the cards using the onboard switches.

   - The logic for the switches uses a switch case statement which only allows one switch to be flipped at a time to avoid confusion.
   - This was originally a file in Lab 3 which was modified to contain new signals for the card_flip and the card x and y positions as well as to use the aformentioned switch case statement
 
- The **card** module creates the actual cards that will be displayed using carddraw 1 -> C processes then runs the game logic in (insert # of processes) and finally handles the coloring in a new Color process

  - insert descriptions of the logic
  - possibly add logic diagrams
  - describe how this is modified version of ball from lab 3

 - The **vga_sync** module handles the utilization of the VGA displaying by using a clock to drive horizontal and vertical counters
   - These counters are then used to generate the various timing signals.
   - The vertical and horizontal sync waveforms, vsync and hsync, will go directly to the VGA display with the column and row address, pixel_col and pixel_row, of the current pixel being displayed.
   - This module also takes as input the current red, green, and blue video data and gates it with a signal called video_on.
   - This ensures that no video is sent to the display during the sync and blanking periods.
   - Note that red, green, and blue video are each represented as 1-bit (on-off) quantities

- The **card_memory** constraint file contains the 100MHz clock signal, vga connections, and all of the board switches
- The two **clk_wiz**
  
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

