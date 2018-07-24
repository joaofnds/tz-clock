LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;

ENTITY counter_setter IS
	PORT (
		keys: IN STD_LOGIC_VECTOR(3 DOWNTO 0);

		q_hours, q_min: OUT INTEGER
	);
END counter_setter;

ARCHITECTURE behavior OF counter_setter IS
constant KEY_0_UPPER_BOUND: INTEGER := 9;
constant KEY_1_UPPER_BOUND: INTEGER := 5;
constant KEY_2_UPPER_BOUND: INTEGER := 3;
constant KEY_3_UPPER_BOUND: INTEGER := 2;

BEGIN
	PROCESS(keys)
		VARIABLE q_0: INTEGER := 0;
		VARIABLE q_1: INTEGER := 0;
		VARIABLE q_2: INTEGER := 0;
		VARIABLE q_3: INTEGER := 0;
	BEGIN
		-- Unidade minutos
		IF keys(0)'EVENT AND keys(0)='0' THEN
			IF q_0=KEY_0_UPPER_BOUND THEN
				q_0 := 0;
			ELSE
				q_0 := q_0 + 1;
			END IF;
		END IF;

		-- Dezena minutos
		IF keys(1)'EVENT AND keys(1)='0' THEN
			IF q_1=KEY_1_UPPER_BOUND THEN
				q_1 := 0;
			ELSE
				q_1 := q_1 + 1;
			END IF;
		END IF;

		-- Unidade horas
		IF keys(2)'EVENT AND keys(2)='0' THEN
			IF q_2=KEY_2_UPPER_BOUND THEN
				q_2 := 0;
			ELSE
				q_2 := q_2 + 1;
			END IF;
		END IF;

		-- Dezena horas
		IF keys(3)'EVENT AND keys(3)='0' THEN
			IF q_3=KEY_3_UPPER_BOUND THEN
				q_3 := 0;
			ELSE
				q_3 := q_3 + 1;
			END IF;
		END IF;

		q_hours <=(q_3 * 10) + q_2;
		q_min <= (q_1 * 10) + q_0;
	END PROCESS;
END behavior;