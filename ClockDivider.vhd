library IEEE;
 use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- component that slows down internal clock and displays its speed on the FPGA board
entity ClockDivider is
  	port(clk : in std_logic;
        
        	SlowClock : out std_logic);
end ClockDivider;
 architecture behavioral of ClockDivider is

begin
process
        	variable cnt : std_logic_vector(26 downto 0):= "000000000000000000000000000";
        	begin                                                   	
                    	wait until ((clk'EVENT) AND (clk = '1'));
                    	
        	cnt := cnt + 1; -- increments count
             
        	SlowClock <= cnt(26); --slow clock based on cnt(x) vlaue
        	
        	
  	end process;
end behavioral;
