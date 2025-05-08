LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY card IS
	PORT (
		v_sync    : IN STD_LOGIC;
		pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		card_x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		card_y : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		card_flip : IN std_logic;
		red       : OUT STD_LOGIC;
		green     : OUT STD_LOGIC;
		blue      : OUT STD_LOGIC
	);
END card;

ARCHITECTURE Behavioral OF card IS
	CONSTANT size  : INTEGER := 5;
	SIGNAL card_on : STD_LOGIC; -- indicates whether ball is over current pixel position
	
BEGIN
	red <= '1'; -- color setup for red card on white background (face down card)
	green <= NOT card_on;
	blue  <= NOT card_on;
	-- process to draw card current pixel address is covered by card position
	carddraw : PROCESS (card_x, card_y, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x - size) AND
		 (pixel_col <= card_x + size) AND
			 (pixel_row >= card_y - size) AND
			 (pixel_row <= card_y + size) THEN
				card_on <= '1';
		ELSE
			card_on <= '0';
		END IF;
		END PROCESS;
END Behavioral;
