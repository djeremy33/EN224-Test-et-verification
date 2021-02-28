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
begin
  
  PGCD_MaE : process (CLK,RESET)
  begin
    if (RESET = '1') then
      pr_state <= Etat_RESET;
    elsif (clk'event and clk='1')then
      case pr_state is
        when Etat_RESET => 
           -- Next state
            if (idata_en='1') then
                pr_state <= Etat_Compute;
            else
                pr_state <= Etat_RESET;
            end if;
            
            -- Variable initialisation
            data_a <= UNSIGNED(idata_a);
            data_b <= UNSIGNED(idata_b);
            odata_en <= '0';
            odata_a <= x"00000000";
            
        when Etat_Compute => 
            -- Next state
            if (data_a = data_b) then
                pr_state <= Etat_Finished;
            else
                pr_state <= Etat_Compute;
            end if;
            
            --Computing
            if(data_a > data_b) then
                data_a <= data_a - data_b;
            else
                data_b <= data_b - data_a;
            end if;
            
        when Etat_Finished => 
            -- Next state
                pr_state <= Etat_RESET;
                
             -- Output
                odata_en <= '1';
                odata_a <= STD_LOGIC_VECTOR(data_a);

         end case;
    end if;
  end process PGCD_MaE;
  
end Behavioral;
