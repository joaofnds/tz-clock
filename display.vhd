LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;


ENTITY display IS
	PORT (
		value: IN INTEGER RANGE 0 TO 999999;

		display_0,
		display_1,
		display_2,
		display_3,
		display_4,
		display_5: OUT STD_LOGIC_VECTOR(6 downto 0)
	);
END display;

ARCHITECTURE behavior OF display IS

CONSTANT sev_seg_0:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "1000000";
CONSTANT sev_seg_1:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111001";
CONSTANT sev_seg_2:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "0100100";
CONSTANT sev_seg_3:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110000";
CONSTANT sev_seg_4:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "0011001";
CONSTANT sev_seg_5:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010010";
CONSTANT sev_seg_6:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000010";
CONSTANT sev_seg_7:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111000";
CONSTANT sev_seg_8:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
CONSTANT sev_seg_9:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010000";
CONSTANT sev_seg_dash: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0111111";
CONSTANT sev_seg_off:  STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";


SIGNAL display_0_buffer,
		   display_1_buffer,
		   display_2_buffer,
		   display_3_buffer,
		   display_4_buffer,
		   display_5_buffer: STD_LOGIC_VECTOR (6 DOWNTO 0);

BEGIN
	PROCESS(value)
	BEGIN
		CASE (value mod 10) IS
			WHEN 0 => display_0_buffer <= sev_seg_0;
			WHEN 1 => display_0_buffer <= sev_seg_1;
			WHEN 2 => display_0_buffer <= sev_seg_2;
			WHEN 3 => display_0_buffer <= sev_seg_3;
			WHEN 4 => display_0_buffer <= sev_seg_4;
			WHEN 5 => display_0_buffer <= sev_seg_5;
			WHEN 6 => display_0_buffer <= sev_seg_6;
			WHEN 7 => display_0_buffer <= sev_seg_7;
			WHEN 8 => display_0_buffer <= sev_seg_8;
			WHEN 9 => display_0_buffer <= sev_seg_9;
			WHEN OTHERS => display_0_buffer <= sev_seg_dash;
		END CASE;

		CASE ((value/10) mod 10) IS
			WHEN 0 => display_1_buffer <= sev_seg_0;
			WHEN 1 => display_1_buffer <= sev_seg_1;
			WHEN 2 => display_1_buffer <= sev_seg_2;
			WHEN 3 => display_1_buffer <= sev_seg_3;
			WHEN 4 => display_1_buffer <= sev_seg_4;
			WHEN 5 => display_1_buffer <= sev_seg_5;
			WHEN 6 => display_1_buffer <= sev_seg_6;
			WHEN 7 => display_1_buffer <= sev_seg_7;
			WHEN 8 => display_1_buffer <= sev_seg_8;
			WHEN 9 => display_1_buffer <= sev_seg_9;
			WHEN OTHERS => display_1_buffer <= sev_seg_dash;
		END CASE;

		CASE ((value/100) mod 10) IS
			WHEN 0 => display_2_buffer <= sev_seg_0;
			WHEN 1 => display_2_buffer <= sev_seg_1;
			WHEN 2 => display_2_buffer <= sev_seg_2;
			WHEN 3 => display_2_buffer <= sev_seg_3;
			WHEN 4 => display_2_buffer <= sev_seg_4;
			WHEN 5 => display_2_buffer <= sev_seg_5;
			WHEN 6 => display_2_buffer <= sev_seg_6;
			WHEN 7 => display_2_buffer <= sev_seg_7;
			WHEN 8 => display_2_buffer <= sev_seg_8;
			WHEN 9 => display_2_buffer <= sev_seg_9;
			WHEN OTHERS => display_2_buffer <= sev_seg_dash;
		END CASE;

		CASE ((value/1000) mod 10) IS
			WHEN 0 => display_3_buffer <= sev_seg_0;
			WHEN 1 => display_3_buffer <= sev_seg_1;
			WHEN 2 => display_3_buffer <= sev_seg_2;
			WHEN 3 => display_3_buffer <= sev_seg_3;
			WHEN 4 => display_3_buffer <= sev_seg_4;
			WHEN 5 => display_3_buffer <= sev_seg_5;
			WHEN 6 => display_3_buffer <= sev_seg_6;
			WHEN 7 => display_3_buffer <= sev_seg_7;
			WHEN 8 => display_3_buffer <= sev_seg_8;
			WHEN 9 => display_3_buffer <= sev_seg_9;
			WHEN OTHERS => display_3_buffer <= sev_seg_dash;
		END CASE;

		CASE ((value/10000) mod 10) IS
			WHEN 0 => display_4_buffer <= sev_seg_0;
			WHEN 1 => display_4_buffer <= sev_seg_1;
			WHEN 2 => display_4_buffer <= sev_seg_2;
			WHEN 3 => display_4_buffer <= sev_seg_3;
			WHEN 4 => display_4_buffer <= sev_seg_4;
			WHEN 5 => display_4_buffer <= sev_seg_5;
			WHEN 6 => display_4_buffer <= sev_seg_6;
			WHEN 7 => display_4_buffer <= sev_seg_7;
			WHEN 8 => display_4_buffer <= sev_seg_8;
			WHEN 9 => display_4_buffer <= sev_seg_9;
			WHEN OTHERS => display_4_buffer <= sev_seg_dash;
		END CASE;

		CASE ((value/100000) mod 10) IS
			WHEN 0 => display_5_buffer <= sev_seg_0;
			WHEN 1 => display_5_buffer <= sev_seg_1;
			WHEN 2 => display_5_buffer <= sev_seg_2;
			WHEN 3 => display_5_buffer <= sev_seg_3;
			WHEN 4 => display_5_buffer <= sev_seg_4;
			WHEN 5 => display_5_buffer <= sev_seg_5;
			WHEN 6 => display_5_buffer <= sev_seg_6;
			WHEN 7 => display_5_buffer <= sev_seg_7;
			WHEN 8 => display_5_buffer <= sev_seg_8;
			WHEN 9 => display_5_buffer <= sev_seg_9;
			WHEN OTHERS => display_5_buffer <= sev_seg_dash;
		END CASE;
	END PROCESS;

	display_0 <= display_0_buffer;
	display_1 <= display_1_buffer;
	display_2 <= display_2_buffer;
	display_3 <= display_3_buffer;
	display_4 <= display_4_buffer;
	display_5 <= display_5_buffer;
END behavior;
