----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:04:22 10/30/2016 
-- Design Name: 
-- Module Name:    PSR_Modifier - Behavioral 
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
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PSR_Modifier is
    Port ( Alu_op : in  STD_LOGIC_VECTOR (5 downto 0);
           Crs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Alu_Resultado : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0));
end PSR_Modifier;

architecture Behavioral of PSR_Modifier is

begin

process(Alu_op, Alu_Resultado, Crs1, Crs2,reset)
	begin
		if (reset = '1') then
			nzvc <= (others=>'0');
		else
			-- ANDcc or ANDNcc or ORcc or ORNcc or XORcc or XNORcc
			if (Alu_op="010001" OR Alu_op="010101" OR Alu_op="010010" OR Alu_op="010110" OR Alu_op="010011" OR Alu_op="010111") then
				nzvc(3) <= Alu_Resultado(31);--el signo que traiga
				if (conv_integer(Alu_Resultado)=0) then
					nzvc(2) <= '1';--porque el resultado da cero
				else
					nzvc(2) <= '0';
				end if;
				nzvc(1) <= '0';--los operadores logicos no generan overflow ni carry
				nzvc(0) <= '0';
			end if;
			
			-- ADDcc or ADDxcc
			if (Alu_op="010000" or Alu_op="011000") then
				nzvc(3) <= Alu_Resultado(31);
				if (conv_integer(ALU_resultado)=0) then
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				nzvc(1) <= (Crs1(31) and Crs2(31) and (not Alu_Resultado(31))) or ((not Crs1(31)) and (not Crs2(31)) and Alu_Resultado(31));
				nzvc(0) <= (Crs1(31) and Crs2(31)) or ((not Alu_Resultado(31)) and (Crs1(31) or Crs2(31)) );
			end if;
			
			--SUBcc or SUBxcc
			if (Alu_op="010100" or Alu_op="011100") then
				nzvc(3) <= Alu_Resultado(31);
				if (conv_integer(Alu_Resultado)=0) then
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				nzvc(1) <= (Crs1(31) and (not Crs2(31)) and (not Alu_Resultado(31))) or ((not Crs1(31)) and Crs2(31) and Alu_Resultado(31));
				nzvc(0) <= ((not Crs1(31)) and Crs2(31)) or (Alu_Resultado(31) and ((not Crs1(31)) or Crs2(31)));
			end if;
		end if;
		
	end process;
	
end Behavioral;

