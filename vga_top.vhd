LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY vga_top IS
    PORT (
        clk_in    : IN STD_LOGIC;
        SW : IN STD_LOGIC_VECTOR (15 downto 0);
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
    -- card x and y coordinates in rows/columns format
    Constant cy1 : std_logic_vector(10 downto 0) := conv_std_logic_vector(100,11);
    Constant cy2 : std_logic_vector(10 downto 0) := conv_std_logic_vector(300,11);
    Constant cy3 : std_logic_vector(10 downto 0) := conv_std_logic_vector(500,11);
    
    Constant cx1 : std_logic_vector(10 downto 0) := conv_std_logic_vector(100,11);
    Constant cx2 : std_logic_vector(10 downto 0) := conv_std_logic_vector(300,11);
    Constant cx3 : std_logic_vector(10 downto 0) := conv_std_logic_vector(500,11);
    Constant cx4 : std_logic_vector(10 downto 0) := conv_std_logic_vector(700,11);
    
    Signal value : STD_LOGIC_VECTOR (3 DOWNTO 0);
	Signal hit : STD_LOGIC := '0';
	
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
    Signal RESET : std_logic := '0';
    --this component is where the game will happen
    COMPONENT card IS
        PORT (
            v_sync : IN STD_LOGIC;
            pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    
		    card_x1 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    card_y1 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    card_flip1 : IN STD_LOGIC;
		    
		    card_x2 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    card_y2 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    card_flip2 : IN STD_LOGIC;
		    
		    card_x3 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    card_y3 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    card_flip3 : IN STD_LOGIC;
		    
		    card_x4 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    card_flip4 : IN STD_LOGIC;
		    card_flip5 : IN STD_LOGIC;
		    card_flip6 : IN STD_LOGIC;
		    card_flip7 : IN STD_LOGIC;
		    card_flip8 : IN STD_LOGIC;
		    card_flip9 : IN STD_LOGIC;
		    card_flipA : IN STD_LOGIC;
		    card_flipB : IN STD_LOGIC;
		    card_flipC : IN STD_LOGIC;
		    
		    hit : IN STD_LOGIC;
		    RESET : IN STD_LOGIC;
		    
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

    cardgame: card
    PORT MAP(
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col, 
        card_x1    => cx1,
        card_y1    => cy1,
        card_flip1 => flip1,
        
        card_x2    => cx2,
        card_y2    => cy2,
        card_flip2 => flip2,
        
        card_x3    => cx3,
        card_y3    => cy3,
        card_flip3 => flip3,
        
        card_x4    => cx4,
        card_flip4 => flip4,
        
        card_flip5 => flip5,
        card_flip6 => flip6,
        card_flip7 => flip7,
        card_flip8 => flip8,
        card_flip9 => flip9,
        card_flipA => flipA,
        card_flipB => flipB,
        card_flipC => flipC,
        
        hit => hit,
        RESET => RESET,
        
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
    

    clk_wiz_0_inst : clk_wiz_0 
    port map (
      clk_in1 => clk_in,
      clk_out1 => pxl_clk
    );
    
Process (flip1, flip2, flip3, flip4, flip5, flip6, flip7, flip8, flip9, flipA, flipB, flipC, hit, value)
begin
    
    case SW is
    when "0000000000000001" => flip1 <= '0'; hit <='1';
    when "0000000000000010" => flip2 <= '0'; hit <='1';
    when "0000000000000100" => flip3 <= '0'; hit <='1';
    when "0000000000001000" => flipA <= '0'; hit <='1';
    when "0000000000010000" => flip4 <= '0'; hit <='1';
    when "0000000000100000" => flip5 <= '0'; hit <='1';
    when "0000000001000000" => flip6 <= '0'; hit <='1';
    when "0000000010000000" => flipB <= '0'; hit <='1';
    when "0000000100000000" => flip7 <= '0'; hit <='1';
    when "0000001000000000" => flip8 <= '0'; hit <='1';
    when "0000010000000000" => flip9 <= '0'; hit <='1';
    when "0000100000000000" => flipC <= '0'; hit <='1';
    when "1000000000000000" => RESET <= '1'; 
    
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
    hit <= '0';
    RESET <= '0';
    end case;

 
END process;
    
END Behavioral;
