----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:35:42 10/30/2016 
-- Design Name: 
-- Module Name:    PSR - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PSR is
    Port ( nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           reset  : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           carry_salida : out  STD_LOGIC);
end PSR;

architecture Behavioral of PSR is

begin

process(reset,clk,nzvc)
	begin
		if reset='1' then
			carry_salida <= '0';
		else
			if rising_edge(clk) then
				carry_salida<=nzvc(0);
			end if;
		end if;
	end process;
	
end Behavioral;




