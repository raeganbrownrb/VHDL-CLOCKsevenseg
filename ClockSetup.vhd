----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2018 07:43:01 PM
-- Design Name: 
-- Module Name: ClockSetup - Behavioral
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
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ClockSetup is
port ( clk3, reset3, increment1, decrement1: in std_logic; 
digit: in std_logic_vector (3 downto 0);
out1, out2, out3, out4 : out std_logic_vector (3 downto 0);
an : out std_logic_vector (3 downto 0);
seg : out std_logic_vector ( 6 downto 0));
end ClockSetup;
architecture Behavioral of ClockSetup is
component SevenSeg 
    Port ( clk : in STD_LOGIC;
           reset: in STD_LOGIC; 
            num1, num2, num3, num4 : in Std_logic_vector (3 downto 0);
              
           Anode : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
           Seven : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal D1 , D2, D3, D4: std_logic_vector ( 3 downto 0):= "0000";
signal anode2: std_logic_vector ( 3 downto 0);
signal segment2 : std_logic_vector( 6 downto 0);

signal counter: STD_LOGIC_VECTOR (27 downto 0);
signal enable: std_logic;
begin
out1 <= D1;
out2 <= D2;
out3 <= D3;
out4 <= D4;
an <= anode2;
seg <= segment2;
instance1: SevenSeg
port map (clk => clk3 , reset => reset3, num1 => D1, num2 =>D2, num3 => D3, num4 => D4, anode => anode2, seven => segment2);
process(reset3, clk3, digit,increment1, decrement1)
begin
        if(reset3='1') then
   counter <= (others => '0');
elsif(clk3' event and clk3 = '1') then
    if(counter>=x"5F5E0FF") then
        counter <= (others => '0');
    else
       counter <= counter + "0000001";
    end if;
end if;
end process;
enable <= '1' when counter=x"5F5E0FF" else '0';
process(clk3, reset3)
begin
if(reset3='1') then
    d1 <= (others => '0');
    d2 <= (others => '0');
    d3 <= (others => '0');
    d4 <= (others => '0');
elsif(clk3' event and clk3 = '1') then
     if(enable = '1') then
         if (increment1 = '1') then
            if digit = "1000" then
               if d4 = "0010" then
                d4 <= "0000";
                else
                d4 <= d4 + "0001";
                end if;
            elsif digit = "0100" then
              if d4 = "0010" then
                 if d3 = "0100" then
                 d3 <= "0000";
                 end if;
                 elsif d3 = "1001" then
                  d3 <= "0000";
             
                  else
                 d3 <= d3 + "0001";
                end if;
            elsif digit = "0010" then
               if d2 = "0101" then
                  d2 <= "0000";
                 else
                d2 <= d2 + "0001";
                end if;
           elsif digit = "0001" then
             if d1 = "1001" then
                        d1 <= "0000";
                        else
                        d1 <= d1 + "0001";
                        end if;
              end if;
         elsif ( decrement1 = '1' ) then -- if decrement pressed decrement
          if digit = "1000" then
            if d4 = "0000" then
                      d4 <= "0010";
                      else
                      d4 <= d4 - "0001";
                      end if;
           elsif digit = "0100" then
          if d3 = "0000" then
                                 d3 <= "1001";
                                 else
                                 d3 <= d3 - "0001";
                                 end if;
           elsif digit = "0010" then
            if d2 = "0000" then
                                 d2 <= "0101";
                                 else
                                 d2 <= d2 - "0001";
                                 end if;
          elsif digit = "0001" then
           if d1 = "0000" then
                                d1 <= "1001";
                                else
                                d1 <= d1 - "0001";
                                end if;
            end if;   
     end if;
     end if;
  
  end if;
  end process;
end Behavioral;
