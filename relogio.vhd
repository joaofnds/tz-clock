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
		HEX5: OUT STD_LOGIC_VECTOR(6 downto 0)
	);

END relogio;

ARCHITECTURE behavior OF relogio IS
SIGNAL is_counting,
			 seconds_load,
			 seconds_reset,
			 minutes_load,
			 minutes_reset,
			 hours_load,
			 hours_reset,
		   one_second_clock,
			 one_minute_clock,
			 one_hour_clock: STD_LOGIC;

SIGNAL seconds_buffer,
			 minutes_buffer,
			 hours_buffer: STD_LOGIC_VECTOR(5 DOWNTO 0);

SIGNAL seconds, minutes, hours: INTEGER;

COMPONENT one_second_tick
	PORT (
		clock: IN STD_LOGIC;
		q: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT counter_60
	PORT (
		clock: IN STD_LOGIC;
		load: IN STD_LOGIC;
		reset: IN STD_LOGIC;
		preset: IN INTEGER;

		q: OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END COMPONENT;

COMPONENT counter_24
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

	seconds_clock: one_second_tick
		PORT MAP (clock => CLOCK_50, q => one_second_clock);

	seconds_counter: counter_60
		PORT MAP (
			clock => one_second_clock,
			load => seconds_load,
			reset => seconds_reset,
			preset => 0,

			q => seconds_buffer
		);


	one_minute_clock <= seconds_buffer(5) AND
											seconds_buffer(4) AND
											seconds_buffer(3) AND
											seconds_buffer(2) AND
											NOT seconds_buffer(1) AND
											NOT seconds_buffer(0);

	minutes_counter: counter_60
		PORT MAP (
			clock => one_minute_clock,
			load => minutes_load,
			reset => minutes_reset,
			preset => 0,

			q => minutes_buffer
		);

	one_hour_clock <= minutes_buffer(5) AND
										minutes_buffer(4) AND
										minutes_buffer(3) AND
										minutes_buffer(2) AND
										NOT minutes_buffer(1) AND
										NOT minutes_buffer(0);

	hours_counter: counter_24
		PORT MAP (
			clock => one_hour_clock,
			load => minutes_load,
			reset => minutes_reset,
			preset => 0,

			q => hours_buffer
		);


	seconds <= to_integer(unsigned(seconds_buffer));
	minutes <= to_integer(unsigned(minutes_buffer));
	hours <= to_integer(unsigned(hours_buffer));
END behavior;