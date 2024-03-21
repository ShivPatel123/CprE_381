LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
-- RIPPPLE CARRY ADDER
ENTITY fulladder_N IS
    GENERIC (N : INTEGER := 32);
    PORT (
        i_x1 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        i_x2 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        i_cin : IN STD_LOGIC := '0';
        o_sum : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        o_cout : OUT STD_LOGIC);
END fulladder_N;

ARCHITECTURE structural OF fulladder_N IS

    COMPONENT fulladder1bit IS
        PORT (
            i_x1 : IN STD_LOGIC;
            i_x2 : IN STD_LOGIC;
            i_cin : IN STD_LOGIC;
            o_sum : OUT STD_LOGIC;
            o_cout : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL carry : STD_LOGIC_VECTOR(N DOWNTO 0);

BEGIN
    carry(0) <= i_cin;
    o_cout <= carry(N);
    G_NBit_fulladder : FOR i IN 0 TO N - 1 GENERATE
        fulladderi : fulladder1bit PORT MAP(
            i_x1 => i_x1(i),
            i_x2 => i_x2(i),
            i_cin => carry(i),
            o_sum => o_sum(i),
            o_cout => carry(i + 1)
        );
    END GENERATE G_NBit_fulladder;

END structural;