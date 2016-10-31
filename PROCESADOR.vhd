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
		Alu_op : IN std_logic_vector(5 downto 0);
		Alu_Resultado : IN std_logic_vector(31 downto 0);
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
		carry_salida : OUT std_logic
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

Inst_sumador: sumador PORT MAP(
		A => x"00000001",
		B => npcTopc,
		salida_sumador =>sumadorTonpc	);

Inst_nPC: nPC PORT MAP(
		clk => clk,
		rst => rst,
		direccion =>sumadorTonpc,
		salida => npcTopc
	);

Inst_PC: nPC PORT MAP(
		clk => clk,
		rst => rst,
		direccion =>npcTopc,
		salida =>pcToim
);		

	Inst_memoriaInstrucciones: memoriaInstrucciones PORT MAP(
		direccion => pcToim,
		instruccion =>  imToucrfseu ,
		rst => rst
	);
	
Inst_UC: UC PORT MAP(
		op => imToucrfseu(31 downto 30), 
		op3 => imToucrfseu(24 downto 19),   
		salida_UC => ucToalu
	);
	
	

Inst_Rf: Rf PORT MAP(
		rf1 =>  imToucrfseu(18 downto 14),   
		rf2 =>   imToucrfseu(4 downto 0),                     
		rd =>   imToucrfseu (29 downto 25),
		crf1 =>  rfToalu1,              
		crf2 =>  rfTomux,
		crd =>   aluTorf,
		rst => rst
	);
		Inst_muxx: muxx PORT MAP(
		i =>  imToucrfseu ( 13 ),
		dato_seu =>seuTomux,
		crs2 =>  rfTomux,
		salida_mux => muxToalu
	);
	
	Inst_seu: seu PORT MAP(
		inmediato13bits =>imToucrfseu (12 downto 0),
		salidaInmediato =>seuTomux
);
	
	
	
	Inst_Alu: Alu PORT MAP(
		suma1 => rfToalu1 ,
		suma2 =>  muxToalu,        
		alu_op =>  ucToalu,
		salida_alu => aluTorf
	);

salida_procesador	<= aluTorf;
	
end Behavioral;

