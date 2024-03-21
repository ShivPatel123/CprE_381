LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
-- AdderSubtractor
ENTITY addersubtractor_N IS
    GENERIC (N : INTEGER := 32);
    PORT (
        i_A : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        i_B : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        i_Imm : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        i_Ctrl : IN STD_LOGIC;
        i_ALUSrc : IN STD_LOGIC;
        o_sum : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        o_cout : OUT STD_LOGIC);
END addersubtractor_N;

ARCHITECTURE mixed OF addersubtractor_N IS

    COMPONENT fulladder_N IS
        GENERIC (N : INTEGER := 32);
        PORT (
            i_x1 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            i_x2 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            i_cin : IN STD_LOGIC := '0';
            o_sum : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            o_cout : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT onescomp_N IS
        GENERIC (N : INTEGER := 32); -- Generic of type integer for input/output data width. Default value is 32.
        PORT (
            i_I : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            o_O : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0));
    END COMPONENT;

    COMPONENT mux2t1_N IS
        GENERIC (N : INTEGER := 32); -- Generic of type integer for input/output data width. Default value is 32.
        PORT (
            i_S : IN STD_LOGIC;
            i_D0 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            i_D1 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            o_O : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0));

    END COMPONENT;

    SIGNAL t_Cout, t_Ctrl, t_B, m1_out, secondVal : STD_LOGIC_VECTOR(N - 1 DOWNTO 0);

BEGIN
    t_Ctrl <= (OTHERS => i_Ctrl);

    BorImm : mux2t1_N PORT MAP(i_S => i_ALUSrc, i_D0 => i_B, i_D1 => i_Imm, o_O => secondVal);

    sub : onescomp_N PORT MAP(i_I => secondVal, o_O => t_B);

    mux : mux2t1_N PORT MAP(i_S => i_Ctrl, i_D0 => secondVal, i_D1 => t_B, o_O => m1_out);

    add : fulladder_N PORT MAP(i_x1 => i_A, i_x2 => m1_out, i_cin => i_Ctrl, o_sum => o_sum, o_cout => o_cout);
END mixed;