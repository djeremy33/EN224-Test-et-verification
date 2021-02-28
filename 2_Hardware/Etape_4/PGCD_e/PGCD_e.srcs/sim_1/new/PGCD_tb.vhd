library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

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
  
  file file_data_a      : text;
  file file_data_b      : text;
  file file_data_c      : text;
  file file_data_c_vhdl : text;

  signal CLK: STD_LOGIC;
  signal RESET: STD_LOGIC;
  signal idata_a: STD_LOGIC_VECTOR (31 downto 0);
  signal idata_b: STD_LOGIC_VECTOR (31 downto 0);
  signal idata_c: STD_LOGIC_VECTOR (31 downto 0);
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
  variable v_ILINE_A    : line;
  variable v_ILINE_B    : line;
  variable v_ILINE_C    : line;
  variable v_OLINE_C    : line;
  variable v_IDATA_A    : std_logic_vector(31 downto 0);
  variable v_IDATA_B    : std_logic_vector(31 downto 0);
  variable v_IDATA_C    : std_logic_vector(31 downto 0);
  begin
  
    -- Put initialisation code here
        RESET <= '1'; 
        idata_a  <= x"00000000";
        idata_b  <= x"00000000";
        idata_en <= '0';
                
    -- Put test bench stimulus code here
        wait for 45ns; 
        RESET <='0';
        
        file_open(file_data_a, "../data_a.txt", read_mode);
        file_open(file_data_b, "../data_b.txt", read_mode);
        file_open(file_data_c, "../data_c.txt", read_mode);
        file_open(file_data_c_vhdl, "../data_c_vhdl.txt", write_mode);
        
        
        while (not endfile(file_data_a)) OR (not endfile(file_data_b)) OR (not endfile(file_data_c)) loop
            readline(file_data_a, v_ILINE_A);
            readline(file_data_b, v_ILINE_B);
            readline(file_data_c, v_ILINE_C);
            read(v_ILINE_A, v_IDATA_A);
            read(v_ILINE_B, v_IDATA_B);
            read(v_ILINE_C, v_IDATA_C);
                    
            idata_a  <= v_IDATA_A;
            idata_b  <= v_IDATA_B;
            idata_c  <= v_IDATA_C;    
            wait for clock_period;
            idata_en <= '1';
            wait for clock_period;
            while odata_en = '0' loop
                    idata_en <= '0';
                    wait for 10 ns;
            end loop; 
            
            ASSERT UNSIGNED(odata_a) = UNSIGNED(idata_c) SEVERITY FAILURE;
            write(v_OLINE_C, odata_a);
            writeline(file_data_c_vhdl, v_OLINE_C);
            
        end loop;
        
        file_close(file_data_a);
        file_close(file_data_b);
        file_close(file_data_c);
        
        wait for 10ns;        
                   
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