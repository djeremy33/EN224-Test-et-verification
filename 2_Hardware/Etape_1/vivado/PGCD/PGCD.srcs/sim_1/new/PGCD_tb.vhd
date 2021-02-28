library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity PGCD_tb is
end;

architecture bench of PGCD_tb is

  component PGCD
      Port ( CLK : in STD_LOGIC;
             RESET : in STD_LOGIC;
             idata_a : in STD_LOGIC_VECTOR (31 downto 0);
             idata_b : in STD_LOGIC_VECTOR (31 downto 0);
             idata_en : in STD_LOGIC;
             odata_a : out STD_LOGIC_VECTOR (31 downto 0);
             odata_en : out STD_LOGIC);
  end component;

  signal CLK: STD_LOGIC;
  signal RESET: STD_LOGIC;
  signal idata_a: STD_LOGIC_VECTOR (31 downto 0);
  signal idata_b: STD_LOGIC_VECTOR (31 downto 0);
  signal idata_en: STD_LOGIC;
  signal odata_a: STD_LOGIC_VECTOR (31 downto 0);
  signal odata_en: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: PGCD port map ( CLK      => CLK,
                       RESET    => RESET,
                       idata_a  => idata_a,
                       idata_b  => idata_b,
                       idata_en => idata_en,
                       odata_a  => odata_a,
                       odata_en => odata_en );

  stimulus: process
  begin
  
    -- Put initialisation code here
        RESET <= '1'; 
        idata_a  <= x"00000000";
        idata_b  <= x"00000000";
        idata_en <= '0';
                
    -- Put test bench stimulus code here
        wait for 45ns; 
        RESET <='0';
        idata_a  <= x"0000000F";
        idata_b  <= x"00000005";
        wait for clock_period;
        idata_en <= '1';
        wait for clock_period;
        idata_en <= '0';
        wait for 10*clock_period;
        
        idata_a  <= x"0000023F";
        idata_b  <= x"00004AC2";
        wait for clock_period;
        idata_en <= '1';
        wait for clock_period;
        idata_en <= '0';
        wait for 60*clock_period;
        
        idata_a  <= x"000FFFFF";
        idata_b  <= x"000FFFFF";
        wait for clock_period;
        idata_en <= '1';
        wait for clock_period;
        idata_en <= '0';
        wait for 55*clock_period;
        
        idata_a  <= x"00000FFF";
        idata_b  <= x"00056234";
        wait for clock_period;
        idata_en <= '1';
        wait for clock_period;
        idata_en <= '0';
        wait for 10*clock_period;
        
        idata_a  <= x"0006523F";
        idata_b  <= x"000ABD26";
        wait for clock_period;
        idata_en <= '1';
        wait for clock_period;
        idata_en <= '0';
        wait for 100*clock_period;
        
    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;