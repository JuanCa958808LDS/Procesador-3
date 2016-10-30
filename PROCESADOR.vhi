
-- VHDL Instantiation Created from source file PROCESADOR.vhd -- 13:20:58 10/17/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT PROCESADOR
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;          
		salida_procesador : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	Inst_PROCESADOR: PROCESADOR PORT MAP(
		clk => ,
		rst => ,
		salida_procesador => 
	);


