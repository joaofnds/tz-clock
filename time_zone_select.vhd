LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY time_zone_select IS
	PORT (
		zone_select: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		zone_value: OUT INTEGER
	);
END time_zone_select;

ARCHITECTURE behavior OF time_zone_select IS

CONSTANT GMT_0: STD_LOGIC_VECTOR(9 DOWNTO 0)   := "0000000000";
CONSTANT GMT_M_5: STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000001";
CONSTANT GMT_M_4: STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000010";
CONSTANT GMT_M_3: STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000100";
CONSTANT GMT_M_2: STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000001000";
CONSTANT GMT_M_1: STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000010000";
CONSTANT GMT_P_1: STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000100000";
CONSTANT GMT_P_2: STD_LOGIC_VECTOR(9 DOWNTO 0) := "0001000000";
CONSTANT GMT_P_3: STD_LOGIC_VECTOR(9 DOWNTO 0) := "0010000000";
CONSTANT GMT_P_4: STD_LOGIC_VECTOR(9 DOWNTO 0) := "0100000000";
CONSTANT GMT_P_5: STD_LOGIC_VECTOR(9 DOWNTO 0) := "1000000000";

BEGIN
	PROCESS(zone_select)
	BEGIN
		CASE zone_select IS
			WHEN GMT_M_5 => zone_value <= -5;
			WHEN GMT_M_4 => zone_value <= -4;
			WHEN GMT_M_3 => zone_value <= -3;
			WHEN GMT_M_2 => zone_value <= -2;
			WHEN GMT_M_1 => zone_value <= -1;
			WHEN GMT_0   => zone_value <=  0;
			WHEN GMT_P_1 => zone_value <=  1;
			WHEN GMT_P_2 => zone_value <=  2;
			WHEN GMT_P_3 => zone_value <=  3;
			WHEN GMT_P_4 => zone_value <=  4;
			WHEN GMT_P_5 => zone_value <=  5;
			WHEN OTHERS => zone_value <= 0;
		END CASE;
	END PROCESS;
END behavior;