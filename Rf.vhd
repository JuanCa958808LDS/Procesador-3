----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:55:59 10/13/2016 
-- Design Name: 
-- Module Name:    Rf - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Rf is
    Port ( rf1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rf2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           crf1 : out  STD_LOGIC_VECTOR (31 downto 0);
           crf2 : out  STD_LOGIC_VECTOR (31 downto 0);
           crd : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC);
end Rf;

architecture Behavioral of Rf is

type ram_type is array (0 to 39) of std_logic_vector (31 downto 0);
	signal reg : ram_type :=(others => x"00000000");

begin
process(rf1,rf2,rst, rd,crd)

begin
	if(rst = '1')then
				crf1<= (others=>'0');
				crf2<= (others=>'0');
			
				reg<= (others => x"00000000");
			else
				crf1<= reg(conv_integer(rf1));
				crf2<= reg(conv_integer(rf2));
				
				
			if(rd  /= "000000")then
					reg(conv_integer(rd)) <= crd;
				end if;
			end if;
	
end process; 

end Behavioral;
