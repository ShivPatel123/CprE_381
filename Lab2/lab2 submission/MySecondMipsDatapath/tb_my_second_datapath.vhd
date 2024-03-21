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
ENTITY tb_my_second_datapath IS
    GENERIC (gCLK_HPER : TIME := 10 ns); -- Generic for half of the clock cycle perioda
END tb_my_second_datapath;

ARCHITECTURE mixed OF tb_my_second_datapath IS

    -- Define the total clock period time
    CONSTANT cCLK_PER : TIME := gCLK_HPER * 2;

    -- We will be instantiating our design under test (DUT), so we need to specify its
    -- component interface.
    -- TODO: change component declaration as needed.

    CONSTANT adder_WIDTH : INTEGER := 32;
    COMPONENT my_second_datapath IS
        PORT (
            i_RSAddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            i_RTAddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            i_RDAddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            i_Imm : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            i_Ctrl : IN STD_LOGIC_VECTOR(3 DOWNTO 0); --0 bit is ALUSRC for using immediate vs using rt. 1 bit is ALUCTRL for adding or subtracting. 2 bit is MEM to REG to decide if the memory value or alu value loops back to reg data. 4th bit is write enable to decide if mem should ready or write (lw or sw)
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
    SIGNAL s_Imm : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s_Ctrl : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL s_RDValue : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_CLK : STD_LOGIC;

BEGIN

    -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
    -- input or output. Note that DUT0 is just the name of the instance that can be seen 
    -- during simulation. What follows DUT0 is the entity name that will be used to find
    -- the appropriate library component during simulation loading.
    DUT0 : my_second_datapath
    PORT MAP(
        i_RSAddress => s_rs_address,
        i_RTAddress => s_rt_address,
        i_RDAddress => s_rd_address,
        i_Imm => s_Imm,
        i_Ctrl => s_Ctrl,
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
        --ctrl: we + memtoreg + aluctrl + alusrc
        --add: ctrl = 0; sub: ctrl = 1
        --immediate: src = 1; reg: src = 0

        --for lw immediate is used as offset, 
        s_rd_address <= "11001"; -- register 25
        s_rs_address <= "00000";
        s_rt_address <= "00000";
        s_Imm <= "0000000000000000";
        s_Ctrl <= "0101"; --Add

        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "11010"; -- register 26
        s_rs_address <= "00000";
        s_rt_address <= "00000";
        s_Imm <= "0000000100000000";
        s_Ctrl <= "0101"; --Add

        -- Load Word
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00001"; -- register 1
        s_rs_address <= "11001";
        s_rt_address <= "00000";
        s_Imm <= "0000000000000000";
        s_Ctrl <= "0001"; --Add

        -- Load Word
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00010"; -- register 2
        s_rs_address <= "11001";
        s_rt_address <= "00000";
        s_Imm <= "0000000000000100";
        s_Ctrl <= "0001"; --Add

        -- Add
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00001"; -- register 1
        s_rs_address <= "00010";
        s_rt_address <= "00001";
        s_Imm <= "0000000000000000";
        s_Ctrl <= "0100"; --Add

        -- Store Word
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00000"; -- register 1
        s_rs_address <= "11010";
        s_rt_address <= "00001";
        s_Imm <= "0000000000000000";
        s_Ctrl <= "1001"; --Add

        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00010"; -- register 2
        s_rs_address <= "11001";
        s_rt_address <= "00000";
        s_Imm <= "0000000000001000";
        s_Ctrl <= "0001"; --Add

        -- Add
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00001"; -- register 1
        s_rs_address <= "00010";
        s_rt_address <= "00001";
        s_Imm <= "0000000000000000";
        s_Ctrl <= "0100"; --Add

        -- Store Word
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00000"; -- register 1
        s_rs_address <= "11010";
        s_rt_address <= "00001";
        s_Imm <= "0000000000000100";
        s_Ctrl <= "1001"; --Add

        --Load word
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00010"; -- register 2
        s_rs_address <= "11001";
        s_rt_address <= "00000";
        s_Imm <= "0000000000001100";
        s_Ctrl <= "0001"; --Add

        -- Add
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00001"; -- register 1
        s_rs_address <= "00010";
        s_rt_address <= "00001";
        s_Imm <= "0000000000000000";
        s_Ctrl <= "0100"; --Add

        -- Store Word
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00000"; -- register 1
        s_rs_address <= "11010";
        s_rt_address <= "00001";
        s_Imm <= "0000000000001000";
        s_Ctrl <= "1001"; --Add

        --Load word
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00010"; -- register 2
        s_rs_address <= "11001";
        s_rt_address <= "00000";
        s_Imm <= "0000000000010000";
        s_Ctrl <= "0001"; --Add

        -- Add
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00001"; -- register 1
        s_rs_address <= "00010";
        s_rt_address <= "00001";
        s_Imm <= "0000000000000000";
        s_Ctrl <= "0100"; --Add

        -- Store Word
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00000"; -- register 1
        s_rs_address <= "11010";
        s_rt_address <= "00001";
        s_Imm <= "0000000000001100";
        s_Ctrl <= "1001"; --Add

        --Load word
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00010"; -- register 2
        s_rs_address <= "11001";
        s_rt_address <= "00000";
        s_Imm <= "0000000000010100";
        s_Ctrl <= "0001"; --Add

        -- Add
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00001"; -- register 1
        s_rs_address <= "00010";
        s_rt_address <= "00001";
        s_Imm <= "0000000000000000";
        s_Ctrl <= "0100"; --Add

        -- Store Word
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00000"; -- register 1
        s_rs_address <= "11010";
        s_rt_address <= "00001";
        s_Imm <= "0000000000010000";
        s_Ctrl <= "1001"; --Add

        --Load word
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00010"; -- register 2
        s_rs_address <= "11001";
        s_rt_address <= "00000";
        s_Imm <= "0000000000011000";
        s_Ctrl <= "0001"; --Add

        -- Add
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00001"; -- register 1
        s_rs_address <= "00010";
        s_rt_address <= "00001";
        s_Imm <= "0000000000000000";
        s_Ctrl <= "0100"; --Add
        -- Addi
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "11011"; -- register 1
        s_rs_address <= "00000";
        s_rt_address <= "00000";
        s_Imm <= "0000001000000000";
        s_Ctrl <= "0101"; --Add

        -- Store Word
        WAIT FOR gCLK_HPER * 2;
        s_rd_address <= "00000"; -- register 1
        s_rs_address <= "11011";
        s_rt_address <= "00001";
        s_Imm <= "1111111111111100";
        s_Ctrl <= "1001"; --Add

        WAIT;
    END PROCESS;
END mixed;