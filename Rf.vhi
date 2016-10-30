
-- VHDL Instantiation Created from source file Rf.vhd -- 11:59:44 10/17/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

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

	Inst_Rf: Rf PORT MAP(
		rf1 => ,
		rf2 => ,
		rd => ,
		crf1 => ,
		crf2 => ,
		crd => ,
		rst => 
	);


