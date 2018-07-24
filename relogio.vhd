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
		HEX5,
		HEX6,
		HEX7: OUT STD_LOGIC_VECTOR(6 downto 0)
	);

END relogio;

ARCHITECTURE behavior OF relogio IS
SIGNAL minutes_load,
			 hours_load,
		   one_second_clock,
			 one_minute_clock,
			 one_hour_clock,
			 load_time: STD_LOGIC;

SIGNAL seconds_buffer,
			 minutes_buffer,
			 hours_buffer: STD_LOGIC_VECTOR(5 DOWNTO 0);

SIGNAL seconds,
			 minutes,
			 hours,
			 tz_value,
			 tz_hour,
			 minutes_preset,
			 hours_preset: INTEGER := 0;

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

COMPONENT display
	PORT (
		value: IN INTEGER RANGE 0 TO 999999;

		display_0,
		display_1,
		display_2,
		display_3,
		display_4,
		display_5: OUT STD_LOGIC_VECTOR(6 downto 0)
	);
END COMPONENT;

COMPONENT time_zone_select
	PORT (
		zone_select: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		zone_value: OUT INTEGER
	);
END COMPONENT;

COMPONENT counter_setter
	PORT (
		keys: IN STD_LOGIC_VECTOR(3 DOWNTO 0);

		q_hours, q_min: OUT INTEGER
	);
END COMPONENT;

BEGIN
	HEX6 <= "1111111";
	HEX7 <= "1111111";

	load_time <= SW(17);

	seconds_clock: one_second_tick
		PORT MAP (
			clock => CLOCK_50,
			q => one_second_clock
		);

	seconds_counter: counter_60
		PORT MAP (
			clock => one_second_clock,
			load => '0',
			reset => '0',
			preset => 0,

			q => seconds_buffer
		);


	one_minute_clock <= NOT (seconds_buffer(5) OR
													 seconds_buffer(4) OR
													 seconds_buffer(3) OR
													 seconds_buffer(2) OR
													 seconds_buffer(1) OR
													 seconds_buffer(0));

	minutes_counter: counter_60
		PORT MAP (
			clock => one_minute_clock,
			load => load_time,
			reset => '0',
			preset => minutes_preset,

			q => minutes_buffer
		);

	one_hour_clock <= NOT (minutes_buffer(5) OR
												 minutes_buffer(4) OR
												 minutes_buffer(3) OR
												 minutes_buffer(2) OR
												 minutes_buffer(1) OR
												 minutes_buffer(0));

	hours_counter: counter_24
		PORT MAP (
			clock => one_hour_clock,
			load => load_time,
			reset => '0',
			preset => hours_preset,

			q => hours_buffer
		);


	seconds <= to_integer(unsigned(seconds_buffer));
	minutes <= to_integer(unsigned(minutes_buffer));
	hours <= to_integer(unsigned(hours_buffer));

	ct_stter: counter_setter
		PORT MAP (
			keys => KEY(3 DOWNTO 0),

			q_min => minutes_preset,
			q_hours => hours_preset
		);

	tz_select: time_zone_select
		PORT MAP (
			zone_select => SW(9 DOWNTO 0),
			zone_value => tz_value
		);

	tz_hour <= (hours + tz_value) MOD 24;

	displays: display
		PORT MAP (
			value => (tz_hour * 10000 + minutes * 100 + seconds),

			display_0 => HEX0,
			display_1 => HEX1,
			display_2 => HEX2,
			display_3 => HEX3,
			display_4 => HEX4,
			display_5 => HEX5
		);
END behavior;