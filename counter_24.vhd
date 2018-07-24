LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.numeric_std.all;

ENTITY counter_24 IS
	PORT (
		clock: IN STD_LOGIC;
		load: IN STD_LOGIC;
		reset: IN STD_LOGIC;
		preset: IN INTEGER;

		q: OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END counter_24;

ARCHITECTURE behavior OF counter_24 IS
constant COUNT_TO: INTEGER := 23;
SIGNAL count: INTEGER RANGE 0 TO COUNT_TO := COUNT_TO;
BEGIN
	PROCESS(clock, reset)
	BEGIN
		IF reset='1' THEN
			count <= 0;
		ELSIF load='1' THEN
			count <= preset;
		ELSIF rising_edge(clock) THEN
			IF count=COUNT_TO THEN
				count <= 0;
			ELSE
				count <= count + 1;
			END IF;
		END IF;

		q <= std_logic_vector(to_signed(count, q'length));
	END PROCESS;
END behavior;