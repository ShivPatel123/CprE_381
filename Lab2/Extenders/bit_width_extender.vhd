LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY bit_width_extender IS
    PORT (
        i_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        o_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));

END bit_width_extender;

ARCHITECTURE behavioral OF bit_width_extender IS

BEGIN
    o_out <= (16 TO 31 => i_in(15)) & (i_in);

END behavioral;