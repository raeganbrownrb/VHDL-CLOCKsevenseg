----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/23/2018 03:00:09 PM
-- Design Name: 
-- Module Name: FSM1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM1 is
port ( clk , reset, hitter : in std_logic;
 switch ,  inc, dec, pause , watch, resets: out std_logic;
 button, an1,an2,an4 : in std_logic_vector ( 3 downto 0);
 segment1, segment2,segment4 :in  std_logic_vector (6 downto 0);
 Anode : out std_logic_vector(3 downto 0);
   Seven : out std_logic_vector ( 6 downto 0));
   end;
architecture beh of FSM1 is
   
 signal anode1, anode2, anode4: std_logic_vector (3 downto 0);
 signal seg1, seg2, seg4 : std_logic_vector (6 downto 0);
 signal slow : std_logic;
 signal cs, ns : std_logic_vector (1 downto 0);
component CLockDivider
	port(clk : in std_logic;
    
        SlowClock : out std_logic);
end component;
begin
 seg1 <= segment1;
 seg2 <= segment2;
 seg4 <= segment4;
 anode1 <= an1;
 anode2 <= an2;
 anode4 <= an4;
instance1 :  clockdivider
port map (clk => clk, slowclock => slow);
process(clk, reset, button)
begin
if reset = '1' then
cs <= "00";
elsif (slow'event and slow= '1') then
cs <= ns;
end if;
end process;
process (cs,button)
begin
case cs is
when "00" =>
watch <= '0';
Anode <= anode1;
Seven <= seg1;
switch <= '0';
resets <= '1';
if button = "0001" then
ns <= "01";
elsif button = "0101" then
ns <= "10";
else
ns <= cs;
end if;
when "01" =>
watch <= '0';
Anode <= anode2;
seven <= seg2;
resets <= '1';
if button = "0010" then
if hitter = '1' then
inc <= '1';
dec <= '0';
end if;
elsif button = "0011" then
if hitter = '1' then
inc <= '0';
dec <='1';
end if;
elsif button = "0000" then
inc <= '0';
dec <= '0';
elsif button = "0100" then
ns <= "00";
switch <= '1';
elsif button = "0101" then
ns <= "10";
else
ns <= cs;
end if;
when "10" =>
seven <= seg4;
anode <= anode4;
watch <= '1';
resets <= '0';
pause <= '1';
if button = "0010" then
pause <= '0';
elsif button = "0100"  then
ns <= "00";
elsif button = "0001" then
ns <= "01";
elsif  button = "0011" then
pause <= '1';
else ns<= cs;
end if;
when others =>
ns <= cs;
end case;
end process;
end Beh;
