LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;

ENTITY relogio IS
	PORT(
		SW: IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		KEY: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		CLOCK_50: IN STD_LOGIC;

		HEX0,
		HEX1,
		HEX2,
		HEX3,
		HEX4,
		HEX5: OUT STD_LOGIC_VECTOR(6 downto 0);
	);

END relogio;

ARCHITECTURE behavior OF relogio IS
SIGNAL is_counting,
		 one_second_clock: STD_LOGIC;

COMPONENT one_second_tick
	PORT (
		clock: IN STD_LOGIC;
		q: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT counter_to_60
	PORT (
		clock: IN STD_LOGIC;
		load: IN STD_LOGIC;
		reset: IN STD_LOGIC;
		preset: IN INTEGER;

		q: OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END COMPONENT;

COMPONENT counter_to_24
	PORT (
		clock: IN STD_LOGIC;
		load: IN STD_LOGIC;
		reset: IN STD_LOGIC;
		preset: IN INTEGER;

		q: OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END COMPONENT;

BEGIN
	is_counting <= SW(17);

	seconds_counter: one_second_tick
		PORT MAP (clock => CLOCK_50, q => one_second_clock);
END behavior;