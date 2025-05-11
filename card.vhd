LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY card IS
	PORT (
		v_sync    : IN STD_LOGIC;
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
	    
		red       : OUT STD_LOGIC;
		green     : OUT STD_LOGIC;
		blue      : OUT STD_LOGIC
	);
END card;

ARCHITECTURE Behavioral OF card IS
	CONSTANT size  : INTEGER := 40;
	SIGNAL card_on1 : STD_LOGIC; -- indicates whether ball is over current pixel position
	SIGNAL card_on2 : STD_LOGIC;
	SIGNAL card_on3 : STD_LOGIC;
	SIGNAL card_on4 : STD_LOGIC;
	SIGNAL card_on5 : STD_LOGIC;
	SIGNAL card_on6 : STD_LOGIC;
	SIGNAL card_on7 : STD_LOGIC;
	SIGNAL card_on8 : STD_LOGIC;
	SIGNAL card_on9 : STD_LOGIC;
	SIGNAL card_onA : STD_LOGIC;
	SIGNAL card_onB : STD_LOGIC;
	SIGNAL card_onC : STD_LOGIC;
	
	
BEGIN
--	red <= '1'; -- color setup for red card on white background (face down card)
--	green <= NOT card_on1;
--	blue  <= NOT card_on1;
	-- process to draw card current pixel address is covered by card position
	carddraw1 : PROCESS (card_x1, card_y1, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x1 - size) AND
		 (pixel_col <= card_x1 + size) AND
			 (pixel_row >= card_y1 - size) AND
			 (pixel_row <= card_y1 + size) THEN
				card_on1 <= '1';
		ELSE
			card_on1 <= '0';
		END IF;
		END PROCESS;
	
	carddraw2 : PROCESS (card_x2, card_y1, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x2 - size) AND
		 (pixel_col <= card_x2 + size) AND
			 (pixel_row >= card_y1 - size) AND
			 (pixel_row <= card_y1 + size) THEN
				card_on2 <= '1';
		ELSE
			card_on2 <= '0';
		END IF;
		END PROCESS;
	carddraw3 : PROCESS (card_x3, card_y1, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x3 - size) AND
		 (pixel_col <= card_x3 + size) AND
			 (pixel_row >= card_y1 - size) AND
			 (pixel_row <= card_y1 + size) THEN
				card_on3 <= '1';
		ELSE
			card_on3 <= '0';
		END IF;
		END PROCESS;
		
	carddrawA : PROCESS (card_x4, card_y1, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x4 - size) AND
		 (pixel_col <= card_x4 + size) AND
			 (pixel_row >= card_y1 - size) AND
			 (pixel_row <= card_y1 + size) THEN
				card_onA <= '1';
		ELSE
			card_onA <= '0';
		END IF;
		END PROCESS;
		
	carddraw4 : PROCESS (card_x1, card_y2, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x1 - size) AND
		 (pixel_col <= card_x1 + size) AND
			 (pixel_row >= card_y2 - size) AND
			 (pixel_row <= card_y2 + size) THEN
				card_on4 <= '1';
		ELSE
			card_on4 <= '0';
		END IF;
		END PROCESS;
		
	carddraw5 : PROCESS (card_x2, card_y2, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x2 - size) AND
		 (pixel_col <= card_x2 + size) AND
			 (pixel_row >= card_y2 - size) AND
			 (pixel_row <= card_y2 + size) THEN
				card_on5 <= '1';
		ELSE
			card_on5 <= '0';
		END IF;
		END PROCESS;
	
	carddraw6 : PROCESS (card_x3, card_y2, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x3 - size) AND
		 (pixel_col <= card_x3 + size) AND
			 (pixel_row >= card_y2 - size) AND
			 (pixel_row <= card_y2 + size) THEN
				card_on6 <= '1';
		ELSE
			card_on6 <= '0';
		END IF;
		END PROCESS;
	
	carddrawB : PROCESS (card_x4, card_y2, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x4 - size) AND
		 (pixel_col <= card_x4 + size) AND
			 (pixel_row >= card_y2 - size) AND
			 (pixel_row <= card_y2 + size) THEN
				card_onB <= '1';
		ELSE
			card_onB <= '0';
		END IF;
		END PROCESS;
	
	carddraw7 : PROCESS (card_x1, card_y3, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x1 - size) AND
		 (pixel_col <= card_x1 + size) AND
			 (pixel_row >= card_y3 - size) AND
			 (pixel_row <= card_y3 + size) THEN
				card_on7 <= '1';
		ELSE
			card_on7 <= '0';
		END IF;
		END PROCESS;
		
	carddraw8 : PROCESS (card_x2, card_y3, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x2 - size) AND
		 (pixel_col <= card_x2 + size) AND
			 (pixel_row >= card_y3 - size) AND
			 (pixel_row <= card_y3 + size) THEN
				card_on8 <= '1';
		ELSE
			card_on8 <= '0';
		END IF;
		END PROCESS;
	
	carddraw9 : PROCESS (card_x3, card_y3, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x3 - size) AND
		 (pixel_col <= card_x3 + size) AND
			 (pixel_row >= card_y3 - size) AND
			 (pixel_row <= card_y3 + size) THEN
				card_on9 <= '1';
		ELSE
			card_on9 <= '0';
		END IF;
		END PROCESS;
	
	carddrawC : PROCESS (card_x4, card_y3, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x4 - size) AND
		 (pixel_col <= card_x4 + size) AND
			 (pixel_row >= card_y3 - size) AND
			 (pixel_row <= card_y3 + size) THEN
				card_onC <= '1';
		ELSE
			card_onC <= '0';
		END IF;
		END PROCESS;
		
	COLOR : PROCESS (card_on1, card_on2, card_on3, card_on4, card_on5, card_on6, card_on7, card_on8, card_on9, card_onA, card_onB, card_onC, card_flip1, card_flip2, card_flip3, card_flip4, card_flip5, card_flip6, card_flip7, card_flip8, card_flip9, card_flipA, card_flipB, card_flipC) IS
	BEGIN
		IF (card_on1 = '1') THEN
				red <= '1'; -- color setup for red card on white background (face down card)
	            green <= NOT card_flip1;
	            blue  <= NOT card_flip1;
	    elsif (card_on2 = '1') then
	            red <= '1'; -- color setup for red card on white background (face down card)
	            green <= NOT card_flip2;
	            blue  <= NOT card_flip2;
	    elsif (card_on3 = '1') then
	            red <= '1'; -- color setup for red card on white background (face down card)
	            green <= NOT card_flip3;
	            blue  <= NOT card_flip3;
	    elsif (card_onA = '1') then
	            red <= '1'; -- color setup for red card on white background (face down card)
	            green <= NOT card_flipA;
	            blue  <= NOT card_flipA;
	    elsif (card_on4 = '1') then
	            red <= '1'; -- color setup for red card on white background (face down card)
	            green <= NOT card_flip4;
	            blue  <= NOT card_flip4;
	    elsif (card_on5 = '1') then
	            red <= '1'; -- color setup for red card on white background (face down card)
	            green <= NOT card_flip5;
	            blue  <= NOT card_flip5;
	    elsif (card_on6 = '1') then
	            red <= '1'; -- color setup for red card on white background (face down card)
	            green <= NOT card_flip6;
	            blue  <= NOT card_flip6;
	    elsif (card_onB = '1') then
	            red <= '1'; -- color setup for red card on white background (face down card)
	            green <= NOT card_flipB;
	            blue  <= NOT card_flipB;
	    elsif (card_on7 = '1') then
	            red <= '1'; -- color setup for red card on white background (face down card)
	            green <= NOT card_flip7;
	            blue  <= NOT card_flip7;
	    elsif (card_on8 = '1') then
	            red <= '1'; -- color setup for red card on white background (face down card)
	            green <= NOT card_flip8;
	            blue  <= NOT card_flip8;
	    elsif (card_on9 = '1') then
	            red <= '1'; -- color setup for red card on white background (face down card)
	            green <= NOT card_flip9;
	            blue  <= NOT card_flip9;
	    elsif (card_onC = '1') then
	            red <= '1'; -- color setup for red card on white background (face down card)
	            green <= NOT card_flipC;
	            blue  <= NOT card_flipC;
		ELSE
			red <= '1'; -- color setup for red card on white background (face down card)
	        green <= '1';
	        blue  <= '1';
		END IF;
		END PROCESS;
END Behavioral;