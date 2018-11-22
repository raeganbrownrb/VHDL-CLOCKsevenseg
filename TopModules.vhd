library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity TopModules is
port ( clk2 , reset2 : in std_logic;
place: in std_logic_vector (3 downto 0);
JA : inout  STD_LOGIC_VECTOR (7 downto 0);
HH : out std_logic;
    Anode1 : out std_logic_vector(3 downto 0);
    Seven1 : out std_logic_vector ( 6 downto 0));
end;

architecture Beh of TopModules is
component clock 
port (clk1, set : in STD_LOGIC;
 I1, I2, I3, I4 : in std_logic_vector (3 downto 0);
           reset1 : in STD_LOGIC; 
            anoded :out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
              sevensegment : out STD_LOGIC_VECTOR (6 downto 0)
           
          );
   end component;
component ClockSetup 
   port ( clk3, reset3, increment1, decrement1: in std_logic;
   digit : in std_logic_vector (3 downto 0);
   out1, out2, out3, out4 : out std_logic_vector (3 downto 0);
   an : out std_logic_vector (3 downto 0);
   seg : out std_logic_vector ( 6 downto 0));
   end component;
component stopwatch 
      port (clks : in STD_LOGIC;
                reset22, stopon : in STD_LOGIC; 
                 anodef :out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
          
                   sevensegm : out STD_LOGIC_VECTOR (6 downto 0); 
                   stop : in std_logic);
         end component;
  component Decoder is
          Port (  clk : in  STD_LOGIC;
                Row : in  STD_LOGIC_VECTOR (3 downto 0);
                   Col : out  STD_LOGIC_VECTOR (3 downto 0);
                    hit : out std_logic;
                DecodeOut : out  STD_LOGIC_VECTOR (3 downto 0));
          end component;
component FSM1 is
port ( clk , reset, hitter : in std_logic;
switch ,  inc, dec, pause, watch,resets : out std_logic;
button, an1,an2,an4 : in std_logic_vector ( 3 downto 0);
 segment1, segment2, segment4 :in  std_logic_vector (6 downto 0);
Anode : out std_logic_vector(3 downto 0);
Seven : out std_logic_vector ( 6 downto 0));
end component;
signal A1, A2, A4, press,v1,v2,v3,v4 : std_logic_vector (3 downto 0);
signal S1, S2, S4 : std_logic_vector (6 downto 0);
signal pausing, up, down , setupon, watchset,R: std_logic := '0';
signal H : std_logic;
  begin
  instance: stopwatch
  port map (clks => clk2, reset22 => R,stopon =>watchset, anodef => A4, sevensegm => S4, stop => pausing);
  instance1 : clock
  port map (clk1 => clk2, reset1 => reset2, set => setupon,  I1 => v1, I2 =>v2, I3 =>v3, I4 => v4, anoded => A1,sevensegment => S1);        
   instance3 : clocksetup
  port map ( clk3 => clk2, reset3 => reset2, increment1 => up, decrement1 => down, digit => place,out1 => v1, out2 => v2, out3 => v3, out4 => v4, an => A2, seg => S2);
  instance2 : FSM1
  port map ( clk => clk2, reset => reset2,hitter => H, switch => setupon, inc => up, dec => down, pause => pausing,watch => watchset,resets => R, button => press, an1 => A1, an2 => A2, an4 => A4, segment1 => s1, segment2 => S2, segment4 => S4,
  Anode => anode1, seven => seven1); 
  instance4: Decoder port map (clk=>clk2, Row =>JA(7 downto 4), Col=>JA(3 downto 0),hit => H, DecodeOut=> press);
HH <= H;
end beh;    
