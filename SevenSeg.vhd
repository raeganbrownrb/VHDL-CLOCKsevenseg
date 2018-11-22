library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity SevenSeg is
    Port ( clk : in STD_LOGIC;
           reset: in STD_LOGIC; 
            num1, num2, num3, num4 : in Std_logic_vector (3 downto 0);
           Anode : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
           Seven : out STD_LOGIC_VECTOR (6 downto 0));
end SevenSeg;

architecture Beh of SevenSeg is

signal input: STD_LOGIC_VECTOR (3 downto 0);
signal refresh: STD_LOGIC_VECTOR (20 downto 0);

signal Activate_count: std_logic_vector(1 downto 0);

begin
--process for conversion of input to seven segment

-- creates a refresh period
process(clk,reset)
begin 
    if(reset='1') then
        refresh <= "000000000000000000000";
    elsif(clk'event and clk = '1') then
        refresh <= refresh + 1;
    end if;
end process;
 Activate_count <= refresh(20 downto 19);
-- 4-to-1 MUX to generate anode activating signals for 4 LEDs 
process(Activate_count,num1,num2,num3,num4)
begin
    case Activate_count is
    when "00" =>
        Anode <= "0111"; 
        -- activate LED1 and Deactivate LED2, LED3, LED4
        input <= num4;
        -- the first hex digit of the 16-bit number
    when "01" =>
        Anode <= "1011"; 
        -- activate LED2 and Deactivate LED1, LED3, LED4
        input <= num3;
        -- the second hex digit of the 16-bit number
    when "10" =>
        Anode<= "1101"; 
        -- activate LED3 and Deactivate LED2, LED1, LED4
        input <= num2;
        -- the third hex digit of the 16-bit number
    when "11" =>
        Anode<= "1110"; 
        -- activate LED4 and Deactivate LED2, LED3, LED1
       input <= num1;
        -- the fourth hex digit of the 16-bit number    
    end case;
end process;

process(input)
begin

    case input is
    when "0000" => 
    seven <= "0000001";      
    when "0001" =>
     Seven <= "1001111";
    when "0010" => 
   Seven <= "0010010"; 
    when "0011" => 
    Seven <= "0000110"; 
    when "0100" => 
    Seven <= "1001100";
    when "0101" => 
    Seven <= "0100100"; 
    when "0110" =>
     Seven <= "0100000"; 
    when "0111" => 
    Seven <= "0001111"; 
    when "1000" => 
    Seven <= "0000000";      
    when "1001" => 
    Seven <= "0000100";
    when others =>
    Seven <= "1111110";
    end case;

end process;
end Beh;