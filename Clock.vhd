library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity clock is
port (clk1, set : in STD_LOGIC;
        I1, I2, I3, I4 : in std_logic_vector (3 downto 0);
           reset1 : in STD_LOGIC; 
            anoded :out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
              sevensegment : out STD_LOGIC_VECTOR (6 downto 0)
          );
   end clock;
architecture beh of clock is
component SevenSeg 
    Port ( clk : in STD_LOGIC;
           reset: in STD_LOGIC; 
            num1, num2, num3, num4 : in Std_logic_vector (3 downto 0);
        
           Anode : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
           Seven : out STD_LOGIC_VECTOR (6 downto 0));
end component;
signal nums1: std_logic_vector(3 downto 0);
signal nums2: std_logic_vector(3 downto 0) ;
signal nums3: std_logic_vector(3 downto 0):= "0010";
signal nums4: std_logic_vector(3 downto 0):="0001";
signal counter: STD_LOGIC_VECTOR (27 downto 0);
signal enable: std_logic;
signal sec : std_logic_vector (5 downto 0):= "000000";
signal segment : std_logic_vector (6 downto 0);
signal anode1 : std_logic_vector (3 downto 0);
begin   
anoded <= anode1;
sevensegment <= segment;
instance1: SevenSeg
port map (clk => clk1 , reset => reset1, num1 => nums1, num2 => nums2, num3 => nums3, num4 => nums4, anode => anode1, seven => segment);
process(clk1, reset1)
begin
        if(reset1='1') then
           counter <= (others => '0');
        elsif(clk1' event and clk1 = '1') then
            if(counter>=x"5F5E0FF") then
                counter <= (others => '0');
            else
               counter <= counter + "0000001";
            end if;
        end if;
end process;
    
enable <= '1' when counter=x"5F5E0FF" else '0';
process(clk1, reset1,set, enable)
begin
        if(reset1='1') then
            nums1 <= (others => '0');
            nums2 <= (others => '0');
            nums3 <= (others => '0');
            nums4 <= (others => '0');
         elsif set = '1' then
          nums1 <= i1;
          nums2 <= i2;
          nums3 <= i3;
          nums4 <= i4;
        elsif(clk1' event and clk1 = '1') then
         
             if(enable = '1') then
            
               sec <= sec + "000001";
               if (sec = "111011") then
               sec <= "000000";
               if (nums4 = "0010" and nums3 = "0100" and nums2 = "0000" and nums1 = "0000") then
               nums4 <= "0000";
               nums3 <= "0000"; 
               nums2 <= "0000";
               nums1 <= "0000";
               else
               nums1 <= nums1 + "0001"; -- and increment a min
                      if (nums1 = "1001") then -- min can not be higher than 9
                      nums1 <= "0000"; -- after hitting 9 , it resets
                      nums2 <= nums2 + "0001"; --tenmin place increments by 1
                      if (nums2 = "0101") then
                      nums2<= "0000"; -- after hitting 9 , it resets
                      nums3 <= nums3 + "0001"; -- hr place is incremented
                      if (nums4 = "0010") then
                       if (nums3 = "0100") then
                        nums3 <= "0001";-- after hitting 9 , it resets
                        end if;
                      elsif (nums4 = "0000" or nums4 = "0001") then
                         if nums3 = "1001" then
                         nums3 <= "0001";
                         nums4 <= nums4 + "0001"; -- tenhr incremented
                          if (nums4 = "0010") then 
             -- because military time it does not go past 2
                           nums4 <= "0000";
                       end if;
                              end if;
                              end if;
                              end if;
                              end if;
                              end if;
                              end if;
                             
           end if;
           end if;
  
end process;

end beh;