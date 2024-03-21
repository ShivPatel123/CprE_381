-------------------------------------------------------------------------
-- Shivansh Patel
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the Two to one mux unit.
--              
-- 01/25/24
-------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_textio.ALL; -- For logic types I/O
LIBRARY std;
USE std.env.ALL; -- For hierarchical/external signals
USE std.textio.ALL; -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
ENTITY tb_myfirstdatapath IS
    GENERIC (gCLK_HPER : TIME := 10 ns); -- Generic for half of the clock cycle perioda
END tb_myfirstdatapath;

ARCHITECTURE mixed OF tb_myfirstdatapath IS

    -- Define the total clock period time
    CONSTANT cCLK_PER : TIME := gCLK_HPER * 2;

    -- We will be instantiating our design under test (DUT), so we need to specify its
    -- component interface.
    -- TODO: change component declaration as needed.

    CONSTANT adder_WIDTH : INTEGER := 32;
    COMPONENT myfirstdatapath IS
        PORT (
            i_RSAddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            i_RTAddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            i_RDAddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            i_Imm : IN STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
            i_Ctrl : IN STD_LOGIC;
            i_ALUSrc : IN STD_LOGIC;
            i_CLK : IN STD_LOGIC;
            o_RDValue : OUT STD_LOGIC_VECTOR(32 - 1 DOWNTO 0));
    END COMPONENT;

    -- Create signals for all of the inputs and outputs of the file that you are testing
    -- := '0' or := (others => '0') just make all the signals start at an initial value of zero
    SIGNAL CLK, reset : STD_LOGIC := '0';

    -- TODO: change input and output signals as needed.

    SIGNAL s_rs_address : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_rt_address : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_rd_address : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_Imm : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_ALUSrc : STD_LOGIC;
    SIGNAL s_Ctrl : STD_LOGIC;
    SIGNAL s_RDValue : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_CLK : STD_LOGIC;

BEGIN

    -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
    -- input or output. Note that DUT0 is just the name of the instance that can be seen 
    -- during simulation. What follows DUT0 is the entity name that will be used to find
    -- the appropriate library component during simulation loading.
    DUT0 : myfirstdatapath
    PORT MAP(
        i_RSAddress => s_rs_address,
        i_RTAddress => s_rt_address,
        i_RDAddress => s_rd_address,
        i_Imm => s_Imm,
        i_Ctrl => s_Ctrl,
        i_ALUSrc => s_ALUSrc,
        i_CLK => s_CLK,
        o_RDValue => s_RDValue
    );

    P_CLK : PROCESS
    BEGIN
        s_CLK <= '0';
        WAIT FOR gCLK_HPER;
        s_CLK <= '1';
        WAIT FOR gCLK_HPER;
    END PROCESS;

    Cases : PROCESS
    BEGIN

        WAIT FOR gCLK_HPER/2;
        s_ALUSrc <= '1'; --use immediate
        s_rd_address <= "00001"; -- register 1
        s_rs_address <= "00000";
        s_rt_address <= "00000";
        s_Imm <= "00000000000000000000000000000001"; -- 1
        s_Ctrl <= '0'; --Add

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '1';
        s_rd_address <= "00010";
        s_rs_address <= "00000";
        s_rt_address <= "00000";
        s_Imm <= "00000000000000000000000000000010";
        s_Ctrl <= '0';

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '1';
        s_rd_address <= "00011";
        s_rs_address <= "00000";
        s_rt_address <= "00000";
        s_Imm <= "00000000000000000000000000000011";
        s_Ctrl <= '0';

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '1';
        s_rd_address <= "00100";
        s_rs_address <= "00000";
        s_rt_address <= "00000";
        s_Imm <= "00000000000000000000000000000100";
        s_Ctrl <= '0';

        WAIT FOR gCLK_HPER * 2;
        s_ALUSrc <= '1';
        s_rd_address <= "00101";
        s_rs_address <= "00000";
        s_rt_address <= "00000";
        s_Imm <= "00000000000000000000000000000101";
        s_Ctrl <= '0';

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '1';
        s_rd_address <= "00110";
        s_rs_address <= "00000";
        s_rt_address <= "00000";
        s_Imm <= "00000000000000000000000000000110";
        s_Ctrl <= '0';

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '1';
        s_rd_address <= "00111";
        s_rs_address <= "00000";
        s_rt_address <= "00000";
        s_Imm <= "00000000000000000000000000000111";
        s_Ctrl <= '0';

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '1';
        s_rd_address <= "01000";
        s_rs_address <= "00000";
        s_rt_address <= "00000";
        s_Imm <= "00000000000000000000000000001000";
        s_Ctrl <= '0';

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '1';
        s_rd_address <= "01001";
        s_rs_address <= "00000";
        s_rt_address <= "00000";
        s_Imm <= "00000000000000000000000000001001";
        s_Ctrl <= '0';

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '1';
        s_rd_address <= "01010";
        s_rs_address <= "00000";
        s_rt_address <= "00000";
        s_Imm <= "00000000000000000000000000001010";
        s_Ctrl <= '0';

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '0'; --use rt address 
        s_rd_address <= "01011";
        s_rs_address <= "00001";
        s_rt_address <= "00010";
        s_Imm <= "00000000000000000000000000000000";
        s_Ctrl <= '0';

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '0';
        s_rd_address <= "01100";
        s_rs_address <= "01011";
        s_rt_address <= "00011";
        s_Imm <= "00000000000000000000000000000000";
        s_Ctrl <= '1';

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '0'; --use rt address 
        s_rd_address <= "01101";
        s_rs_address <= "01100";
        s_rt_address <= "00100";
        s_Ctrl <= '0';

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '0'; --use rt address 
        s_rd_address <= "01110";
        s_rs_address <= "01101";
        s_rt_address <= "00101";
        s_Ctrl <= '1';

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '0'; --use rt address 
        s_rd_address <= "01111";
        s_rs_address <= "01110";
        s_rt_address <= "00110";
        s_Ctrl <= '0';

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '0'; --use rt address 
        s_rd_address <= "10000";
        s_rs_address <= "01111";
        s_rt_address <= "00111";
        s_Ctrl <= '1';

        WAIT FOR gCLK_HPER * 2;

        s_rd_address <= "10001";
        s_rs_address <= "10000";
        s_rt_address <= "01000";
        s_Ctrl <= '0';

        WAIT FOR gCLK_HPER * 2;

        s_rd_address <= "10010";
        s_rs_address <= "10001";
        s_rt_address <= "01001";
        s_Ctrl <= '1';

        WAIT FOR gCLK_HPER * 2;

        s_rd_address <= "10011";
        s_rs_address <= "10010";
        s_rt_address <= "01010";
        s_Ctrl <= '0';

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '1'; --use immediate
        s_rd_address <= "10100";
        s_rs_address <= "00000";
        s_rt_address <= "00000";
        s_Imm <= X"FFFFFFDD";
        s_Ctrl <= '0'; --Add

        WAIT FOR gCLK_HPER * 2;

        s_ALUSrc <= '0';
        s_rd_address <= "10101";
        s_rs_address <= "10011";
        s_rt_address <= "10100";
        s_Imm <= X"00000000";
        s_Ctrl <= '0'; --Add

        WAIT FOR gCLK_HPER * 2;

        WAIT;
    END PROCESS;
END mixed;