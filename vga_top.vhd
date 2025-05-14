LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY vga_top IS
    PORT (
        clk_in    : IN STD_LOGIC;
        KB_row : IN STD_LOGIC_VECTOR (4 downto 1);
        KB_col : OUT STD_LOGIC_VECTOR (4 downto 1);
        vga_red : OUT STD_LOGIC_VECTOR (2 downto 0);
        vga_green : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        vga_blue  : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        vga_hsync : OUT STD_LOGIC;
        vga_vsync : OUT STD_LOGIC
    );
END vga_top;

ARCHITECTURE Behavioral OF vga_top IS
    SIGNAL pxl_clk : STD_LOGIC;
    -- internal signals to connect modules
    SIGNAL S_red, S_green, S_blue : STD_LOGIC;
    SIGNAL S_vsync : STD_LOGIC;
    SIGNAL S_pixel_row, S_pixel_col : STD_LOGIC_VECTOR (10 DOWNTO 0);
    
    Constant cy1 : std_logic_vector(10 downto 0) := conv_std_logic_vector(150,11);
    Constant cy2 : std_logic_vector(10 downto 0) := conv_std_logic_vector(300,11);
    Constant cy3 : std_logic_vector(10 downto 0) := conv_std_logic_vector(450,11);
    
    Constant cx1 : std_logic_vector(10 downto 0) := conv_std_logic_vector(100,11);
    Constant cx2 : std_logic_vector(10 downto 0) := conv_std_logic_vector(300,11);
    Constant cx3 : std_logic_vector(10 downto 0) := conv_std_logic_vector(500,11);
    Constant cx4 : std_logic_vector(10 downto 0) := conv_std_logic_vector(700,11);
    
    Signal value : STD_LOGIC_VECTOR (3 DOWNTO 0);
	Signal hit : STD_LOGIC;
	
	Signal flip1 : std_logic := '1';
    Signal flip2 : std_logic := '1';
    Signal flip3 : std_logic := '1';
    Signal flip4 : std_logic := '1';
    Signal flip5 : std_logic := '1';
    Signal flip6 : std_logic := '1';
    Signal flip7 : std_logic := '1';
    Signal flip8 : std_logic := '1';
    Signal flip9 : std_logic := '1';
    Signal flipA : std_logic := '1';
    Signal flipB : std_logic := '1';
    Signal flipC : std_logic := '1';
    
    
    COMPONENT card IS
        PORT (
            v_sync : IN STD_LOGIC;
            pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            card_x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    card_y : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    card_flip : IN STD_LOGIC;
            red : OUT STD_LOGIC;
            green : OUT STD_LOGIC;
            blue : OUT STD_LOGIC
        );
    END COMPONENT;
    COMPONENT vga_sync IS
        PORT (
            pixel_clk : IN STD_LOGIC;
            red_in    : IN STD_LOGIC;
            green_in  : IN STD_LOGIC;
            blue_in   : IN STD_LOGIC;
            red_out   : OUT STD_LOGIC;
            green_out : OUT STD_LOGIC;
            blue_out  : OUT STD_LOGIC;
            hsync     : OUT STD_LOGIC;
            vsync     : OUT STD_LOGIC;
            pixel_row : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
            pixel_col : OUT STD_LOGIC_VECTOR (10 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT keypad IS
	PORT (
		samp_ck : IN STD_LOGIC; -- clock to strobe columns
		col : OUT STD_LOGIC_VECTOR (4 DOWNTO 1); -- output column lines
		row : IN STD_LOGIC_VECTOR (4 DOWNTO 1); -- input row lines
		value : OUT STD_LOGIC_VECTOR (3 DOWNTO 0); -- hex value of key depressed
	    hit : OUT STD_LOGIC); -- indicates when a key has been pressed
    END COMPONENT;
    
    component clk_wiz_0 is
    port (
      clk_in1  : in std_logic;
      clk_out1 : out std_logic
    );
    end component;
    
    
BEGIN
    -- vga_driver only drives MSB of red, green & blue
    -- so set other bits to zero
    vga_red(1 DOWNTO 0) <= "00";
    vga_green(1 DOWNTO 0) <= "00";
    vga_blue(0) <= '0';

    card1: card
    PORT MAP(
        --instantiate ball component
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col, 
        card_x    => cx1,
        card_y    => cy1,
        card_flip => flip1,
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue
    );
    card2: card
    PORT MAP(
        --instantiate ball component
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col, 
        card_x    => cx2,
        card_y    => cy1,
        card_flip => flip2,
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue
    );
    card3: card
    PORT MAP(
        --instantiate ball component
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col,
        card_x    => cx3,
        card_y    => cy1,
        card_flip => flip3,
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue
    );
    card4: card
    PORT MAP(
        --instantiate ball component
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col,
        card_x    => cx1,
        card_y    => cy2,
        card_flip => flip4,
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue
    );
    card5: card
    PORT MAP(
        --instantiate ball component
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col,
        card_x    => cx2,
        card_y    => cy2,
        card_flip => flip5,
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue
    );
    card6: card
    PORT MAP(
        --instantiate ball component
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col,
        card_x    => cx3,
        card_y    => cy2,
        card_flip => flip6,
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue
    );
    card7: card
    PORT MAP(
        --instantiate ball component
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col,
        card_x    => cx1,
        card_y    => cy3,
        card_flip => flip7,
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue
    );
    card8: card
    PORT MAP(
        --instantiate ball component
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col,
        card_x    => cx2,
        card_y    => cy3,
        card_flip => flip8,
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue
    );
    card9: card
    PORT MAP(
        --instantiate ball component
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col,
        card_x    => cx3,
        card_y    => cy3,
        card_flip => flip9,
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue
    );
    cardA: card
    PORT MAP(
        --instantiate ball component
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col,
        card_x    => cx4,
        card_y    => cy1,
        card_flip => flipA,
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue
    );
    cardB: card
    PORT MAP(
        --instantiate ball component
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col,
        card_x    => cx4,
        card_y    => cy2,
        card_flip => flipB,
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue
    );
    cardC: card
    PORT MAP(
        --instantiate ball component
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col,
        card_x    => cx4,
        card_y    => cy3,
        card_flip => flipC,
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue
    );


    vga_driver : vga_sync
    PORT MAP(
        --instantiate vga_sync component
        pixel_clk => pxl_clk, 
        red_in    => S_red, 
        green_in  => S_green, 
        blue_in   => S_blue, 
        red_out   => vga_red(2), 
        green_out => vga_green(2), 
        blue_out  => vga_blue(1), 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col, 
        hsync     => vga_hsync, 
        vsync     => S_vsync
    );
    vga_vsync <= S_vsync; --connect output vsync
    
    kp: keypad
    port map(
        samp_ck        => pxl_clk,
	    col            => KB_col,
	    row            => KB_row,
        value          => value,
	    hit            => hit
	    );
	    
    clk_wiz_0_inst : clk_wiz_0 
    port map (
      clk_in1 => clk_in,
      clk_out1 => pxl_clk
    );
    
Process (flip1, flip2, flip3, flip4, flip5, flip6, flip7, flip8, flip9, flipA, flipB, flipC, hit, value)
begin

case hit & value is
    when "10001" => flip1 <= '0';
    when "10010" => flip2 <= '0';
    when "10011" => flip3 <= '0';
    when "10100" => flip4 <= '0';
    when "10101" => flip5 <= '0';
    when "10110" => flip6 <= '0';
    when "10111" => flip7 <= '0';
    when "11000" => flip8 <= '0';
    when "11001" => flip9 <= '0';
    when "11010" => flipA <= '0';
    when "11011" => flipB <= '0';
    when "11100" => flipC <= '0';
    when others => 
    flip1 <= '1';
    flip2 <= '1';
    flip3 <= '1';
    flip4 <= '1';
    flip5 <= '1';
    flip6 <= '1';
    flip7 <= '1';
    flip8 <= '1';
    flip9 <= '1';
    flipA <= '1';
    flipB <= '1';
    flipC <= '1';
    end case;


END process;
    
END Behavioral;
