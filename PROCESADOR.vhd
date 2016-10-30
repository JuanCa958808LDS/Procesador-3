----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:29:56 10/17/2016 
-- Design Name: 
-- Module Name:    PROCESADOR - Behavioral 
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

entity PROCESADOR is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           salida_procesador  : out  STD_LOGIC_VECTOR (31 downto 0));
end PROCESADOR;

architecture Behavioral of PROCESADOR is


	COMPONENT sumador
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);          
		salida_sumador : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT nPC
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		direccion : IN std_logic_vector(31 downto 0);          
		salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT memoriaInstrucciones
	PORT(
		direccion : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		instruccion : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;COMPONENT UC
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		salida_UC : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

	

COMPONENT Rf
	PORT(
		rf1 : IN std_logic_vector(4 downto 0);
		rf2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		crd : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		crf1 : OUT std_logic_vector(31 downto 0);
		crf2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
COMPONENT muxx
	PORT(
		i : IN std_logic;
		dato_seu : IN std_logic_vector(31 downto 0);
		crs2 : IN std_logic_vector(31 downto 0);          
		salida_mux : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT seu
	PORT(
		inmediato13bits : IN std_logic_vector(12 downto 0);          
		salidaInmediato : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT PSR_Modifier
	PORT(
		ALUOP : IN std_logic_vector(5 downto 0);
		ALU_Result : IN std_logic_vector(31 downto 0);
		Crs1 : IN std_logic_vector(31 downto 0);
		Crs2 : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		nzvc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;



	COMPONENT PSR
	PORT(
		nzvc : IN std_logic_vector(3 downto 0);
		reset : IN std_logic;
		clk : IN std_logic;          
		carry : OUT std_logic
		);
	END COMPONENT;





	COMPONENT Alu
	PORT(
		suma1 : IN std_logic_vector(31 downto 0);
		suma2 : IN std_logic_vector(31 downto 0);
		alu_op : IN std_logic_vector(5 downto 0);          
		salida_alu : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	

	

signal sumadorTonpc, npcTopc,pcToim,imToucrfseu,rfToalu1,rfTomux,aluTorf, seuTomux, muxToalu : STD_LOGIC_VECTOR (31 downto 0);
signal ucToalu: STD_LOGIC_VECTOR (5 downto 0);
begin

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR is
    Port ( nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           (carry : out  STD_LOGIC);
end PSR;

architecture Behavioral of PSR is

begin

	process(reset,clk,nzvc)
	begin
		if reset='1' then
			carry <= '0';
		else
			if rising_edge(clk) then
				carry<=nzvc(0);
			end if;
		end if;
	end process;
	
end Behavioral;

