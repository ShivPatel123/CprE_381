LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
-- AdderSubtractor
ENTITY my_second_datapath IS
    PORT (
        i_RSAddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        i_RTAddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        i_RDAddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        i_Imm : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        i_Ctrl : IN STD_LOGIC_VECTOR(3 DOWNTO 0); --0 bit is ALUSRC for using immediate vs using rt. 1 bit is ALUCTRL for adding or subtracting. 2 bit is MEM to REG to decide if the memory value or alu value loops back to reg data. 4th bit is write enable to decide if mem should ready or write (lw or sw)
        i_CLK : IN STD_LOGIC;
        o_RDValue : OUT STD_LOGIC_VECTOR(32 - 1 DOWNTO 0));
END my_second_datapath;

ARCHITECTURE structural OF my_second_datapath IS

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

    COMPONENT bit_width_extender IS
        PORT (
            i_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            o_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));

    END COMPONENT;

    COMPONENT mem IS
        GENERIC (
            DATA_WIDTH : NATURAL := 32;
            ADDR_WIDTH : NATURAL := 10
        );
        PORT (
            clk : IN STD_LOGIC;
            addr : IN STD_LOGIC_VECTOR((ADDR_WIDTH - 1) DOWNTO 0);
            data : IN STD_LOGIC_VECTOR((DATA_WIDTH - 1) DOWNTO 0);
            we : IN STD_LOGIC := '1';
            q : OUT STD_LOGIC_VECTOR((DATA_WIDTH - 1) DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux2t1_N IS
        GENERIC (N : INTEGER := 32); -- Generic of type integer for input/output data width. Default value is 32.
        PORT (
            i_S : IN STD_LOGIC;
            i_D0 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            i_D1 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            o_O : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0));

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

    SIGNAL RS_Data, RT_Data, RD_Data, Imm, ALUOut, memOut : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

    registerfile : mips_reg_file PORT MAP(i_CLK => i_CLK, i_rsaddress => i_RSAddress, i_rtaddress => i_RTAddress, i_rdaddress => i_RDAddress, i_rddata => RD_Data, o_rsvalue => RS_Data, o_rtvalue => RT_Data);

    signextender : bit_width_extender PORT MAP(i_in => i_Imm, o_out => Imm);

    alu : addersubtractor_N PORT MAP(i_A => RS_Data, i_B => RT_Data, i_Imm => Imm, i_Ctrl => i_Ctrl(1), i_ALUSrc => i_Ctrl(0), o_sum => ALUOut);

    memory : mem PORT MAP(clk => i_CLK, addr => ALUOut(9 DOWNTO 0), data => RT_Data, we => i_Ctrl(3), q => memOut);

    mux : mux2t1_N PORT MAP(i_S => i_Ctrl(2), i_D0 => memOut, i_D1 => ALUOut, o_O => RD_Data);

    o_RDValue <= RD_Data;

END structural;