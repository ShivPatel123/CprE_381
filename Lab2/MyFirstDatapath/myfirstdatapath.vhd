LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
-- AdderSubtractor
ENTITY myfirstdatapath IS
    PORT (
        i_RSAddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        i_RTAddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        i_RDAddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        i_Imm : IN STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
        i_Ctrl : IN STD_LOGIC;
        i_ALUSrc : IN STD_LOGIC;
        i_CLK : IN STD_LOGIC;
        o_RDValue : OUT STD_LOGIC_VECTOR(32 - 1 DOWNTO 0));
END myfirstdatapath;

ARCHITECTURE structural OF myfirstdatapath IS

    COMPONENT mips_reg_file IS
        PORT (
            i_CLK : IN STD_LOGIC;
            i_rsaddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            i_rtaddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            i_rdaddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            i_rddata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_rsvalue : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_rtvalue : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );

    END COMPONENT;

    COMPONENT addersubtractor_N IS
        GENERIC (N : INTEGER := 32);
        PORT (
            i_A : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            i_B : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            i_Imm : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            i_Ctrl : IN STD_LOGIC;
            i_ALUSrc : IN STD_LOGIC;
            o_sum : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            o_cout : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL RS_Data, RT_Data, RD_Data : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

    registerfile : mips_reg_file PORT MAP(i_CLK => i_CLK, i_rsaddress => i_RSAddress, i_rtaddress => i_RTAddress, i_rdaddress => i_RDAddress, i_rddata => RD_Data, o_rsvalue => RS_Data, o_rtvalue => RT_Data);

    alu : addersubtractor_N PORT MAP(i_A => RS_Data, i_B => RT_Data, i_Imm => i_Imm, i_Ctrl => i_Ctrl, i_ALUSrc => i_ALUSrc, o_sum => RD_Data);

    o_RDValue <= RD_Data;

END structural;