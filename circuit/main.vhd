----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:58:29 03/16/2017 
-- Design Name: 
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
	Port ( outp : out  STD_LOGIC_VECTOR (7 downto 0);
			  clk : in STD_LOGIC);
end main;

architecture Behavioral of main is

	-- ROM TYPE --
	type ROM8x8 is array(0 to 7) of std_logic_vector (7 downto 0);
	signal MyRom : ROM8x8;
	
	-- CLOCKS --
	signal clk_2 : std_logic;
	signal count_2 : unsigned (30 downto 0) := (others => '0');
	signal whereToRead : integer range 0 to 7 := 0;
	
	-- READ STUFF
	signal bin_value : std_logic_vector (7 downto 0) := (others => '0');
	
	
begin -- MAIN BEGIN
	

	
	
--	MyRom <= (
--			"00000001",
--			"00000010",
--			"00000100",
--			"00001000",
--			"00010000",
--			"00100000",
--			"01000000",
--			"10000000"
--			);
			
	
	
-- READ STUFF ------------------- READ STUFF ----------------------------
process  
      file file_pointer : text;
		variable line_content : string(1 to 4);
      variable line_num : line;
		variable j : integer := 0;
		variable char : character:='0';
		variable i : integer := 0;
		
   begin
		--Open the file read.txt from the specified location for reading(READ_MODE).
      file_open(file_pointer,"C:\ROM_v2\circuit\read.txt", READ_MODE);	  
      while not endfile(file_pointer) loop --till the end of file is reached continue.
			readline (file_pointer,line_num);  --Read the whole line from the file
			--Read the contents of the line from  the file into a variable.
			READ (line_num,line_content);  
			--For each character in the line convert it to binary value.
			--And then store it in a signal named 'bin_value'.
			for j in 1 to 4 loop		 
				char := line_content(j);
				if(char = '0') then
					bin_value(4-j) <= '0';
				elsif (char = '1') then 
					bin_value(4-j) <= '1';
				else 
					bin_value(7) <= '1'; 
				end if;	
			end loop;	
			--wait for 10 ns; --after reading each line wait for 10ns.
			MyRom(i) <= bin_value;
			i := i + 1;
			
      end loop;
      file_close(file_pointer);  --after reading all the lines close the file.	
		--wait; -- på hvad?
    end process;




	 
			
			
			
			
			
			
			
-- PROCESS CLOCK ---------------- MAIN CLOCK --------			
	process(clk)
		begin
			if clk='1' and clk'event then 
				count_2 <= count_2 + 1;
			end if;
			clk_2 <= count_2(23);	
	end process;


-- SECOND CLOCK ----------------- SECOND CLOCK ------
process(clk_2)

begin
	if clk_2='1' and clk_2'event then
--				outp(0) <= tempStorage(0);
--				outp(1) <= tempStorage(1);
--				outp(2) <= tempStorage(2);
--				outp(3) <= tempStorage(3);
--				outp(4) <= tempStorage(4);
--				outp(5) <= tempStorage(5);
--				outp(6) <= tempStorage(6); 
--				outp(7) <= tempStorage(7); 
--				outp <= RAM(2);

		outp <= MyRom(whereToRead);
--		outp(0) <= bin_value(0);
--		outp(1) <= bin_value(1);
--		outp(2) <= bin_value(2);
--		outp(3) <= bin_value(3);
--		outp(4) <= '0';
--		outp(5) <= '0';
--		outp(6) <= '0';
--		outp(7) <= bin_value(7);
		
	else 
		whereToRead <= whereToRead + 1;
		--outp <= (others => '1');
	end if;
end process; 







end Behavioral; -- MAIN END

