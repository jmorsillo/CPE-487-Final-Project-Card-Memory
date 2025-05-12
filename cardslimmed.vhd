LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY card IS
	PORT (
		v_sync : IN STD_LOGIC;
            pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    
		    card_x1 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    card_y1 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    
		    card_x2 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    card_y2 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		   
		    card_x3 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    card_y3 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    
		    card_x4 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		    
		    card_flip : in std_logic_vector (11 downto 0);
		    
		    hit : IN STD_LOGIC;
		    RESET : IN STD_LOGIC;
		    
            red : OUT STD_LOGIC;
            green : OUT STD_LOGIC;
            blue : OUT STD_LOGIC
	);
END card;

ARCHITECTURE Behavioral OF card IS
	CONSTANT size  : INTEGER := 50;
	SIGNAL card_on : std_logic_vector (11 downto 0);
	SIGNAL card_lock : std_logic_vector (11 downto 0) := "000000000000";
	
	SIGNAL game_complete : std_logic_vector (5 downto 0) := "000000";
	
	SIGNAL fail : STD_LOGIC := '0';
	SIGNAL flop : STD_LOGIC;
	SIGNAL temp_flop : STD_LOGIC := '1';
	
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
				card_on(0) <= '1';
		ELSE
			card_on(0) <= '0';
		END IF;
		END PROCESS;
	
	carddraw2 : PROCESS (card_x2, card_y1, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x2 - size) AND
		 (pixel_col <= card_x2 + size) AND
			 (pixel_row >= card_y1 - size) AND
			 (pixel_row <= card_y1 + size) THEN
				card_on(1) <= '1';
		ELSE
			card_on(1) <= '0';
		END IF;
		END PROCESS;
	carddraw3 : PROCESS (card_x3, card_y1, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x3 - size) AND
		 (pixel_col <= card_x3 + size) AND
			 (pixel_row >= card_y1 - size) AND
			 (pixel_row <= card_y1 + size) THEN
				card_on(2) <= '1';
		ELSE
			card_on(2) <= '0';
		END IF;
		END PROCESS;
		
	carddrawA : PROCESS (card_x4, card_y1, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x4 - size) AND
		 (pixel_col <= card_x4 + size) AND
			 (pixel_row >= card_y1 - size) AND
			 (pixel_row <= card_y1 + size) THEN
				card_on(9) <= '1';
		ELSE
			card_on(9) <= '0';
		END IF;
		END PROCESS;
		
	carddraw4 : PROCESS (card_x1, card_y2, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x1 - size) AND
		 (pixel_col <= card_x1 + size) AND
			 (pixel_row >= card_y2 - size) AND
			 (pixel_row <= card_y2 + size) THEN
				card_on(3) <= '1';
		ELSE
			card_on(3) <= '0';
		END IF;
		END PROCESS;
		
	carddraw5 : PROCESS (card_x2, card_y2, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x2 - size) AND
		 (pixel_col <= card_x2 + size) AND
			 (pixel_row >= card_y2 - size) AND
			 (pixel_row <= card_y2 + size) THEN
				card_on(4) <= '1';
		ELSE
			card_on(4) <= '0';
		END IF;
		END PROCESS;
	
	carddraw6 : PROCESS (card_x3, card_y2, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x3 - size) AND
		 (pixel_col <= card_x3 + size) AND
			 (pixel_row >= card_y2 - size) AND
			 (pixel_row <= card_y2 + size) THEN
				card_on(5) <= '1';
		ELSE
			card_on(5) <= '0';
		END IF;
		END PROCESS;
	
	carddrawB : PROCESS (card_x4, card_y2, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x4 - size) AND
		 (pixel_col <= card_x4 + size) AND
			 (pixel_row >= card_y2 - size) AND
			 (pixel_row <= card_y2 + size) THEN
				card_on(10) <= '1';
		ELSE
			card_on(10) <= '0';
		END IF;
		END PROCESS;
	
	carddraw7 : PROCESS (card_x1, card_y3, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x1 - size) AND
		 (pixel_col <= card_x1 + size) AND
			 (pixel_row >= card_y3 - size) AND
			 (pixel_row <= card_y3 + size) THEN
				card_on(6) <= '1';
		ELSE
			card_on(6) <= '0';
		END IF;
		END PROCESS;
		
	carddraw8 : PROCESS (card_x2, card_y3, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x2 - size) AND
		 (pixel_col <= card_x2 + size) AND
			 (pixel_row >= card_y3 - size) AND
			 (pixel_row <= card_y3 + size) THEN
				card_on(7) <= '1';
		ELSE
			card_on(7) <= '0';
		END IF;
		END PROCESS;
	
	carddraw9 : PROCESS (card_x3, card_y3, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x3 - size) AND
		 (pixel_col <= card_x3 + size) AND
			 (pixel_row >= card_y3 - size) AND
			 (pixel_row <= card_y3 + size) THEN
				card_on(8) <= '1';
		ELSE
			card_on(8) <= '0';
		END IF;
		END PROCESS;
	
	carddrawC : PROCESS (card_x4, card_y3, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= card_x4 - size) AND
		 (pixel_col <= card_x4 + size) AND
			 (pixel_row >= card_y3 - size) AND
			 (pixel_row <= card_y3 + size) THEN
				card_on(11) <= '1';
		ELSE
			card_on(11) <= '0';
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
	
	
	Phase : PROCESS 
	begin
	wait until (rising_edge(hit));
	   flop <= temp_flop;
	   temp_flop <= not(temp_flop);
	END PROCESS;
	
	Game : PROCESS
	begin
	wait until (rising_edge(v_sync));
	   If (RESET = '1') then
	       card_lock <= "000000000000";
	       game_complete <= "000000";
	       
	   Elsif(fail <= '1') then
	       card_lock <= "000000000000";
	       fail <= '0';
	       
	   Elsif(game_complete(0) <= '1') then
	       card_lock(0) <= '1';
	       card_lock(1) <= '1';
	   Elsif(game_complete(1) <= '1') then
	       card_lock(2) <= '1';
	       card_lock(9) <= '1';
	   Elsif(game_complete(2) <= '1') then
	       card_lock(3) <= '1';
	       card_lock(4) <= '1';
	   Elsif(game_complete(3) <= '1') then
	       card_lock(5) <= '1';
	       card_lock(10) <= '1';
	   Elsif(game_complete(4) <= '1') then
	       card_lock(6) <= '1';
	       card_lock(7) <= '1';
	   Elsif(game_complete(5) <= '1') then
	       card_lock(8) <= '1';
	       card_lock(11) <= '1';
	       end if;
	       
	   if(flop = '0')then
	           IF(card_flip(0) = '0')then
	               card_lock(0) <= '1';
	           ELSIF(card_flip(1) = '0')then
	               card_lock(1) <= '1';
	           ELSIF(card_flip(2) = '0')then
	               card_lock(2) <= '1';
	           ELSIF(card_flip(9) = '0')then
	               card_lock(9) <= '1';
	           ELSIF(card_flip(3) = '0')then
	               card_lock(3) <= '1';
	           ELSIF(card_flip(4) = '0')then
	               card_lock(4) <= '1';
	           ELSIF(card_flip(5) = '0')then
	               card_lock(5) <= '1';
	           ELSIF(card_flip(10) = '0')then
	               card_lock(10) <= '1';
	           ELSIF(card_flip(6) = '0')then
	               card_lock(6) <= '1';
	           ELSIF(card_flip(7) = '0')then
	               card_lock(7) <= '1'; 
	           ELSIF(card_flip(8) = '0')then
	               card_lock(8) <= '1';
	           ELSIF(card_flip(11) = '0')then
	               card_lock(11) <= '1';
	           END IF;
	           
	   IF(flop = '1')then
	           IF((card_flip(0)='0' OR card_lock(0)='1') AND (card_flip(1)='0' OR card_lock(1)='1')) then
	                   game_complete(0) <= '1';
	               else
	                   fail <= '1';
	               end if;
	               
	           IF((card_flip(2)='0' OR card_lock(2)='1') AND (card_flip(9)='0' OR card_lock(9)='1')) then
	                   game_complete(1) <= '1';
	               else
	                   fail <= '1';
	               end if;
	               
	           IF((card_flip(3)='0' OR card_lock(3)='1') AND (card_flip(4)='0' OR card_lock(4)='1')) then
	                   game_complete(2) <= '1';
	               else
	                   fail <= '1';
	               end if;
	               
	           IF((card_flip(5)='0' OR card_lock(5)='1') AND (card_flip(10)='0' OR card_lock(10)='1')) then
	                   game_complete(3) <= '1';
	               else
	                   fail <= '1';
	               end if;
	               
	           IF((card_flip(6)='0' OR card_lock(6)='1') AND (card_flip(7)='0' OR card_lock(7)='1')) then
	                   game_complete(4) <= '1';
	               else
	                   fail <= '1';
	               end if;
	               
	           IF((card_flip(8)='0' OR card_lock(8)='1') AND (card_flip(11)='0' OR card_lock(11)='1')) then
	                   game_complete(0) <= '1';
	               else
	                   fail <= '1';
	               end if;
	           END IF;
	       end if;
	   END PROCESS;
	 
	COLOR : PROCESS (card_on, card_lock, card_flip) IS
	BEGIN
		IF (card_on(0) = '1') THEN --CARD 1 BLUE+GREEN FLIP
		      IF (card_lock(0) = '1')then
		        red <= '0';
		        green <= '1';
		        blue <= '1';
		      Else
				red <= card_flip(0); 
	            green <= NOT card_flip(0);
	            blue  <= NOT card_flip(0);
	          end if;
	          
	    elsif (card_onTEST = '1') then
	       IF (flop = '0') then
	           red <= '0';
	           green <= '0';
	           blue <= '0';
	       Elsif (flop = '1') then
	           red <= '1';
	           green <= '0';
	           blue <= '0';
	       end if;
	       
	    elsif (card_on(1) = '1') then --CARD 2 BLUE+GREEN FLIP
	          IF (card_lock(1) = '1')then
		        red <= '0';
		        green <= '1';
		        blue <= '1';
		      Else
				red <= card_flip(1); 
	            green <= NOT card_flip(1);
	            blue  <= NOT card_flip(1);
	          end if;
	    elsif (card_on(2) = '1') then --CARD 3 BLUE FLIP
	           IF (card_lock(2) = '1')then
	            red <= '0';
	            green <= '0';
	            blue <= '1';
	           Else
	            red <= card_flip(2); 
	            green <= '0';
	            blue  <= NOT card_flip(2);
	           end if;
	    elsif (card_on(9) = '1') then --CARD A BLUE FLIP
	           IF (card_lock(9) = '1')then
	            red <= '0';
	            green <= '0';
	            blue <= '1';
	           Else
	            red <= card_flip(9); 
	            green <= '0';
	            blue  <= NOT card_flip(9);
	           end if;
	    elsif (card_on(3) = '1') then --CARD 4 RED+BLUE FLIP
	           IF (card_lock(3) = '1')then
	            red <= '1'; 
	            green <= '0';
	            blue  <= '1';
	           Else
	            red <= '1';
	            green <= '0';
	            blue  <= NOT card_flip(3);
	           end if;
	    elsif (card_on(4) = '1') then --CARD 5 RED+BLUE FLIP
	           IF (card_lock(4) = '1')then
	            red <= '1'; 
	            green <= '0';
	            blue  <= '1';
	           Else
	            red <= '1';
	            green <= '0';
	            blue  <= NOT card_flip(4);
	           end if;
	    elsif (card_on(5) = '1') then --CARD 6 GREEN FLIP
	           IF (card_lock(5) = '1')then
	            red <= '0';
	            green <= '1';
	            blue  <= '0';
	           Else	  	           
	            red <= card_flip(5); 
	            green <= NOT card_flip(5);
	            blue  <= '0';
	           end if;
	    elsif (card_on(10) = '1') then --CARD B GREEN FLIP
	           IF (card_lock(10) = '1')then
	            red <= '0';
	            green <= '1';
	            blue  <= '0';
	           Else	  	           
	            red <= card_flip(10); 
	            green <= NOT card_flip(10);
	            blue  <= '0';
	           end if;
	    elsif (card_on(6) = '1') then --CARD 7 RED+GREEN FLIP
	           IF (card_lock(6) = '1')then
	            red <= '1';
	            green <= '1';
	            blue  <= '0';
	           Else
	            red <= '1'; 
	            green <= NOT card_flip(6);
	            blue  <= '0';
	           end if;
	    elsif (card_on(7) = '1') then --CARD 8 RED+GREEN FLIP
	           IF (card_lock(7) = '1')then
	            red <= '1';
	            green <= '1';
	            blue  <= '0';
	           Else
	            red <= '1'; 
	            green <= NOT card_flip(7);
	            blue  <= '0';
	           end if;
	    elsif (card_on(8) = '1') then --CARD 9 NO COLOR? FLIP
	           IF (card_lock(8) = '1')then
	            red <= '0';
	            green <= '0';
	            blue  <= '0';
	           Else
	            red <= card_flip(8); 
	            green <= '0';
	            blue  <= '0';
	           end if;
	    elsif (card_on(11) = '1') then --CARD C NO COLOR? FLIP
	           IF (card_lock(11) = '1')then
	            red <= '0';
	            green <= '0';
	            blue  <= '0';
	           Else
	            red <= card_flip(11); 
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
