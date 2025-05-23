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
	    
	    hit : IN STD_LOGIC;
	    RESET : IN STD_LOGIC;
	    
		red       : OUT STD_LOGIC;
		green     : OUT STD_LOGIC;
		blue      : OUT STD_LOGIC
	);
END card;

ARCHITECTURE Behavioral OF card IS
	--size of cards, 2x size is side length of the square
	CONSTANT size  : INTEGER := 40;

	--signals for whether current pixel is on an individual card
	SIGNAL card_on1 : STD_LOGIC; 
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

	--signals for when a card is flipped over, 0 for hidden, 1 for flipped over/exposed
	SIGNAL card_lock1 : STD_LOGIC := '0'; 
	SIGNAL card_lock2 : STD_LOGIC := '0';
	SIGNAL card_lock3 : STD_LOGIC := '0';
	SIGNAL card_lock4 : STD_LOGIC := '0';
	SIGNAL card_lock5 : STD_LOGIC := '0';
	SIGNAL card_lock6 : STD_LOGIC := '0';
	SIGNAL card_lock7 : STD_LOGIC := '0';
	SIGNAL card_lock8 : STD_LOGIC := '0';
	SIGNAL card_lock9 : STD_LOGIC := '0';
	SIGNAL card_lockA : STD_LOGIC := '0';
	SIGNAL card_lockB : STD_LOGIC := '0';
	SIGNAL card_lockC : STD_LOGIC := '0';

	--signals to detect when a pair of cards has been found
	SIGNAL game_complete1 : STD_LOGIC := '0'; 
	SIGNAL game_complete2 : STD_LOGIC := '0';
	SIGNAL game_complete3 : STD_LOGIC := '0';
	SIGNAL game_complete4 : STD_LOGIC := '0';
	SIGNAL game_complete5 : STD_LOGIC := '0';
	SIGNAL game_complete6 : STD_LOGIC := '0';

	-- signal for detecting when an incorrect pair of cards has been chosen
	SIGNAL fail : STD_LOGIC := '0';

	-- signal for detecting input of the rising edge of turning on a switch
	SIGNAL flip : STD_LOGIC := '0';

	-- test card in the corner so you can observe whats going on
	SIGNAL xtest : std_logic_vector (10 downto 0) := conv_std_logic_vector(800,11);
	SIGNAL ytest : std_logic_vector (10 downto 0) := conv_std_logic_vector(600,11);
	SIGNAL card_ontest : STD_LOGIC := '0';
	
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
	
	carddrawTEST : PROCESS (xtest, ytest, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= xtest - size) AND
		 (pixel_col <= xtest + size) AND
			 (pixel_row >= ytest - size) AND
			 (pixel_row <= ytest + size) THEN
				card_onTEST <= '1';
		ELSE
			card_onTEST <= '0';
		END IF;
		END PROCESS;

	-- process that detects when an input is given by rising edge of a hit variable which turns on when an input is given
	Phase : PROCESS 
	begin
	wait until (rising_edge(hit));
	   flip <= NOT(flip);
	END PROCESS;
		
	--Actual game is done here
	Game : PROCESS 
	begin
	wait until (rising_edge(v_sync));
	--Code intializing checking if any pairs are found on each cycle, and will show them if they are
	   If(game_complete1 = '1') then
	       card_lock1 <= '1';
	       card_lock2 <= '1';
	   end if;
	   If(game_complete2 = '1') then
	       card_lock3 <= '1';
	       card_lockA <= '1';
	   end if;
	   If(game_complete3 = '1') then
	       card_lock4 <= '1';
	       card_lock5 <= '1';
	   end if;
	   If(game_complete4 = '1') then
	       card_lock6 <= '1';
	       card_lockB <= '1';
	   end if;
	   If(game_complete5 = '1') then
	       card_lock7 <= '1';
	       card_lock8 <= '1';
	   end if;
	   If(game_complete6 = '1') then
	       card_lock9 <= '1';
	       card_lockC <= '1';
	   end if;

	-- if you hit the reset button it reverts back to the start of the game
	   If (RESET = '1') then
	       card_lock1 <= '0';
	       card_lock2 <= '0';
	       card_lock3 <= '0';
	       card_lockA <= '0';
	       card_lock4 <= '0';
	       card_lock5 <= '0';
	       card_lock6 <= '0';
	       card_lockB <= '0';
	       card_lock7 <= '0';
	       card_lock8 <= '0';
	       card_lock9 <= '0';
	       card_lockC <= '0';
	       game_complete1 <= '0';
	       game_complete2 <= '0';
	       game_complete3 <= '0';
	       game_complete4 <= '0';
	       game_complete5 <= '0';
	       game_complete6 <= '0';

	-- if you choose a wrong pair of cards, it wipes every card, this is counter acted by the game_complete signals
	   Elsif (fail = '1') then
	       card_lock1 <= '0';
	       card_lock2 <= '0';
	       card_lock3 <= '0';
	       card_lockA <= '0';
	       card_lock4 <= '0';
	       card_lock5 <= '0';
	       card_lock6 <= '0';
	       card_lockB <= '0';
	       card_lock7 <= '0';
	       card_lock8 <= '0';
	       card_lock9 <= '0';
	       card_lockC <= '0';
	       fail <= '0';
	           
	   elsif (hit='1')  then
		-- First card decision
	       IF(flip = '1')then
	           IF(card_flip1 = '0') AND (card_lock1 = '0') then
	               card_lock1 <= '1';
	               hits <='1';
	               --prevValue <= 1;
	           ELSIF(card_flip2 = '0') AND (card_lock2 = '0') then
	               card_lock2 <= '1';
	               hits <='1';
	           ELSIF(card_flip3 = '0') AND (card_lock3 = '0') then
	               card_lock3 <= '1';
	               hits <='1';
	           ELSIF(card_flipA = '0') AND (card_lockA = '0') then
	               card_lockA <= '1';
	               hits <='1';
	           ELSIF(card_flip4 = '0') AND (card_lock4 = '0') then
	               card_lock4 <= '1';
	               hits <='1';
	           ELSIF(card_flip5 = '0') AND (card_lock5 = '0') then
	               card_lock5 <= '1';
	               hits <='1';
	           ELSIF(card_flip6 = '0') AND (card_lock6 = '0') then
	               card_lock6 <= '1';
	               hits <='1';
	           ELSIF(card_flipB = '0') AND (card_lockB = '0') then
	               card_lockB <= '1';
	               hits <='1';
	           ELSIF(card_flip7 = '0') AND (card_lock7 = '0') then
	               card_lock7 <= '1';
	               hits <='1';
	           ELSIF(card_flip8 = '0') AND (card_lock8 = '0') then
	               card_lock8 <= '1';
	               hits <='1'; 
	           ELSIF(card_flip9 = '0') AND (card_lock9 = '0') then
	               card_lock9 <= '1';
	               hits <='1';
	           ELSIF(card_flipC = '0') AND (card_lockC = '0') then
	               card_lockC <= '1';
	               hits <='1';
	           END IF;
		--second card decision, and will determine if you find a pair or fail a pair
	       ELSIF(flip = '0')then
	           IF(card_flip1 = '0') AND (card_lock1 = '0')then
	               IF(card_lock2 = '0') then	
	                   hits <='0';
	                   fail <='1';
	               else
	                   card_lock1 <= '1';
	                   hits <= '0';
	                   game_complete1 <= '1';
	               end if;
	               
	           ELSIF(card_flip2 = '0') AND (card_lock2 = '0') then
	               IF(card_lock1 = '0') then	      
	                   hits <='0';
	                   fail <='1';
	               else
	                   card_lock2 <= '1';
	                   hits <= '0';
	                   game_complete1 <= '1';
	               end if;
	           ELSIF(card_flip3 = '0') AND (card_lock3 = '0') then
	               IF(card_lockA = '0') then	
	                   hits <='0';
	                   fail <='1';
	               else
	                   card_lock3 <= '1';
	                   hits <= '0';
	                   game_complete2 <= '1';
	               end if;
	           ELSIF(card_flipA = '0') AND (card_lockA = '0') then
	               IF(card_lock3 = '0') then	
	                   hits <='0';
	                   fail <='1';
	               else
	                   card_lockA <= '1';
	                   hits <= '0';
	                   game_complete2 <= '1';
	               end if;
	           ELSIF(card_flip4 = '0') AND (card_lock4 = '0') then
	               IF(card_lock5 = '0') then	      
	                   hits <='0';
	                   fail <='1';
	               else
	                   card_lock4 <= '1';
	                   hits <= '0';
	                   game_complete3 <= '1';
	               end if;
	           ELSIF(card_flip5 = '0') AND (card_lock5 = '0') then
	               IF(card_lock4 = '0') then	      
	                   hits <='0';
	                   fail <='1';
	               else
	                   card_lock5 <= '1';
	                   hits <= '0';
	                   game_complete3 <= '1';
	               end if;
	           ELSIF(card_flip6 = '0') AND (card_lock6 = '0') then
	               IF(card_lockB = '0') then	      
	                   hits <='0';
	                   fail <='1';
	               else
	                   card_lock6 <= '1';
	                   hits <= '0';
	                   game_complete4 <= '1';
	               end if;
	           ELSIF(card_flipB = '0') AND (card_lockB = '0') then
	               IF(card_lock6 = '0') then	      
	                   hits <='0';
	                   fail <='1';
	               else
	                   card_lockB <= '1';
	                   hits <= '0';
	                   game_complete4 <= '1';
	               end if;
	           ELSIF(card_flip7 = '0') AND (card_lock7 = '0') then
	               IF(card_lock8 = '0') then	      
	                   hits <='0';
	                   fail <='1';
	               else
	                   card_lock7 <= '1';
	                   hits <= '0';
	                   game_complete5 <= '1';
	               end if;
	           ELSIF(card_flip8 = '0') AND (card_lock8 = '0') then
	               IF(card_lock7 = '0') then	      
	                   hits <='0';
	                   fail <='1';
	               else
	                   card_lock8 <= '1';
	                   hits <= '0';
	                   game_complete5 <= '1';
	               end if;
	           ELSIF(card_flip9 = '0') AND (card_lock9 = '0') then
	               IF(card_lockC = '0') then	      
	                   hits <='0';
	                   fail <='1';
	               else
	                   card_lock9 <= '1';
	                   hits <= '0';
	                   game_complete6 <= '1';
	               end if;
	           ELSIF(card_flipC = '0') AND (card_lockC = '0') then
	               IF(card_lock9 = '0') then	      
	                   hits <='0';
	                   fail <='1';
	               else
	                   card_lockC <= '1';
	                   hits <= '0';
	                   game_complete6 <= '1';
	               end if;
	           END IF;
	           
	       END IF;
	   
	   END IF;
	   END PROCESS;

	--displaying visuals process
	COLOR : PROCESS (card_on1, card_on2, card_on3, card_on4, card_on5, card_on6, card_on7, card_on8, card_on9, card_onA, card_onB, card_onC, card_lock1, card_lock2, card_lock3, card_lock4, card_lock5, card_lock6, card_lock7, card_lock8, card_lock9, card_lockA, card_lockB, card_lockC, card_flip1, card_flip2, card_flip3, card_flip4, card_flip5, card_flip6, card_flip7, card_flip8, card_flip9, card_flipA, card_flipB, card_flipC) IS
	BEGIN
		--Will display cards true colors if their lock function is on, red otherwise
		IF (card_on1 = '1') THEN --CARD 1 BLUE+GREEN FLIP
		      IF (card_lock1 = '1')then
		        red <= '0';
		        green <= '1';
		        blue <= '1';
		      Else
				red <= '1'; 
	            green <= '0';
	            blue  <= '0';
	          end if;
	          
	    elsif (card_onTEST = '1') then
	       IF (flip = '0') then
	           red <= '0';
	           green <= '0';
	           blue <= '0';
	       Elsif (flip = '1') then
	           red <= '1';
	           green <= '0';
	           blue <= '0';
	       end if;      
	          
	    elsif (card_on2 = '1') then --CARD 2 BLUE+GREEN FLIP
	          IF (card_lock2 = '1')then
		        red <= '0';
		        green <= '1';
		        blue <= '1';
		      Else
				red <= '1'; 
	            green <= '0';
	            blue  <= '0';
	          end if;
	    elsif (card_on3 = '1') then --CARD 3 BLUE FLIP
	           IF (card_lock3 = '1')then
	            red <= '0';
	            green <= '0';
	            blue <= '1';
	           Else
	            red <= '1'; 
	            green <= '0';
	            blue  <= '0';
	           end if;
	    elsif (card_onA = '1') then --CARD A BLUE FLIP
	           IF (card_lockA = '1')then
	            red <= '0';
	            green <= '0';
	            blue <= '1';
	           Else
	            red <= '1'; 
	            green <= '0';
	            blue  <= '0';
	           end if;
	    elsif (card_on4 = '1') then --CARD 4 RED+BLUE FLIP
	           IF (card_lock4 = '1')then
	            red <= '1'; 
	            green <= '0';
	            blue  <= '1';
	           Else
	            red <= '1'; 
	            green <= '0';
	            blue  <= '0';
	           end if;
	    elsif (card_on5 = '1') then --CARD 5 RED+BLUE FLIP
	           IF (card_lock5 = '1')then
	            red <= '1'; 
	            green <= '0';
	            blue  <= '1';
	           Else
	            red <= '1'; 
	            green <= '0';
	            blue  <= '0';
	           end if;
	    elsif (card_on6 = '1') then --CARD 6 GREEN FLIP
	           IF (card_lock6 = '1')then
	            red <= '0';
	            green <= '1';
	            blue  <= '0';
	           Else	  	           
	            red <= '1'; 
	            green <= '0';
	            blue  <= '0';
	           end if;
	    elsif (card_onB = '1') then --CARD B GREEN FLIP
	           IF (card_lockB = '1')then
	            red <= '0';
	            green <= '1';
	            blue  <= '0';
	           Else	  	           
	            red <= '1'; 
	            green <= '0';
	            blue  <= '0';
	           end if;
	    elsif (card_on7 = '1') then --CARD 7 RED+GREEN FLIP
	           IF (card_lock7 = '1')then
	            red <= '1';
	            green <= '1';
	            blue  <= '0';
	           Else
	            red <= '1'; 
	            green <= '0';
	            blue  <= '0';
	           end if;
	    elsif (card_on8 = '1') then --CARD 8 RED+GREEN FLIP
	           IF (card_lock8 = '1')then
	            red <= '1';
	            green <= '1';
	            blue  <= '0';
	           Else
	            red <= '1'; 
	            green <= '0';
	            blue  <= '0';
	           end if;
	    elsif (card_on9 = '1') then --CARD 9 NO COLOR? FLIP
	           IF (card_lock9 = '1')then
	            red <= '0';
	            green <= '0';
	            blue  <= '0';
	           Else
	            red <= '1'; 
	            green <= '0';
	            blue  <= '0';
	           end if;
	    elsif (card_onC = '1') then --CARD C NO COLOR? FLIP
	           IF (card_lockC = '1')then
	            red <= '0';
	            green <= '0';
	            blue  <= '0';
	           Else
	            red <= '1'; 
	            green <= '0';
	            blue  <= '0';
	           end if;
		ELSE
			red <= '1'; 
	        green <= '1';
	        blue  <= '1';
		END IF;
		END PROCESS;
		
END Behavioral;
