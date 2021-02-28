----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.02.2021 16:39:21
-- Design Name: 
-- Module Name: PGCD - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PGCD is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           idata_a : in STD_LOGIC_VECTOR (31 downto 0);
           idata_b : in STD_LOGIC_VECTOR (31 downto 0);
           idata_en : in STD_LOGIC;
           odata_a : out STD_LOGIC_VECTOR (31 downto 0);
           odata_en : out STD_LOGIC);
end PGCD;

--Probleme :
--      quand idata_a ou idata_b = 0
--      idata_a ou idata_b change de valeur pendant un calcul
architecture Behavioral of PGCD is

  type Etat is (Etat_RESET, Etat_Compute, Etat_Finished);
  signal pr_state : Etat := Etat_RESET;
  signal data_a, data_b : unsigned(31 DOWNTO 0);
  -- pragma translate_off
  signal nb_CLK : unsigned(31 DOWNTO 0);
  -- pragma translate_on
begin
  
  PGCD_MaE : process (CLK,RESET)
  begin
    if (RESET = '1') then
      odata_en <= '0';
      odata_a <= x"00000000";
      pr_state <= Etat_RESET;
    elsif (clk'event and clk='1')then
      case pr_state is
        when Etat_RESET => 
           -- Next state
            if (idata_en='1') then
                assert idata_a > x"00000000" report "a = 0" severity failure; 
                assert idata_a < x"0001000" report "a > 65535" severity failure; 
                assert idata_b > x"00000000" report "b = 0" severity failure; 
                assert idata_b < x"0001000" report "b > 65535" severity failure; 
            -- pragma translate_off    
                nb_CLK <= x"00000000";
            -- pragma translate_on
                pr_state <= Etat_Compute;
            else
                pr_state <= Etat_RESET;
            end if;
            
            -- Variable initialisation
            data_a <= UNSIGNED(idata_a);
            data_b <= UNSIGNED(idata_b);
            odata_en <= '0';
            
        when Etat_Compute => 
            -- Next state
            if ((data_a = data_b) OR (data_a = 0) OR (data_b = 0)) then
                pr_state <= Etat_Finished;
            else
            -- pragma translate_off
                nb_CLK <= nb_CLK + 1;
            -- pragma translate_on
                pr_state <= Etat_Compute;
            end if;
            
            --Computing
            if(data_a > 16*data_b) then
                data_a <= data_a - resize(16*data_b, 32);
            elsif(data_a > 8*data_b) then
                data_a <= data_a - resize(8*data_b, 32);
            elsif(data_a > 4*data_b) then
                data_a <= data_a - resize(4*data_b, 32);
            elsif(data_a > 2*data_b) then
                data_a <= data_a - resize(2*data_b, 32);
            elsif (data_a > data_b) then
                data_a <= data_a - data_b;
            elsif(data_b > 16*data_a) then
                data_b <= data_b - resize(16*data_a, 32);
            elsif(data_b > 8*data_a) then
                data_b <= data_b - resize(8*data_a, 32);
            elsif(data_b > 4*data_a) then
                data_b <= data_b - resize(4*data_a, 32);
            elsif(data_b > 2*data_a) then
                data_b <= data_b - resize(2*data_a, 32);
            else
                data_b <= data_b - data_a;
            end if;
            
        when Etat_Finished => 
            -- Next state
                pr_state <= Etat_RESET;
                
             -- Output
                odata_en <= '1';
                
            -- pragma translate_off
                report  "nbr de cycle d'horloge : " & integer'image(to_integer(nb_CLK)); 
            -- pragma translate_on
                
                if (data_a = 0) then
                    odata_a <= STD_LOGIC_VECTOR(data_b);
                else
                    odata_a <= STD_LOGIC_VECTOR(data_a);
                end if;

         end case;
    end if;
  end process PGCD_MaE;
  
  
  --assert b <= 0 report "b <=0";
  
end Behavioral;
