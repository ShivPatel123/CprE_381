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
ENTITY tb_addersubtractor_N IS
    GENERIC (gCLK_HPER : TIME := 10 ns); -- Generic for half of the clock cycle perioda
END tb_addersubtractor_N;

ARCHITECTURE mixed OF tb_addersubtractor_N IS

    -- Define the total clock period time
    CONSTANT cCLK_PER : TIME := gCLK_HPER * 2;

    -- We will be instantiating our design under test (DUT), so we need to specify its
    -- component interface.
    -- TODO: change component declaration as needed.

    CONSTANT adder_WIDTH : INTEGER := 32;
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

    -- Create signals for all of the inputs and outputs of the file that you are testing
    -- := '0' or := (others => '0') just make all the signals start at an initial value of zero
    SIGNAL CLK, reset : STD_LOGIC := '0';

    -- TODO: change input and output signals as needed.

    SIGNAL s_iA : STD_LOGIC_VECTOR(adder_WIDTH - 1 DOWNTO 0);
    SIGNAL s_iB : STD_LOGIC_VECTOR(adder_WIDTH - 1 DOWNTO 0);
    SIGNAL s_iImm : STD_LOGIC_VECTOR(adder_WIDTH - 1 DOWNTO 0);
    SIGNAL s_iALUSrc : STD_LOGIC;
    SIGNAL s_iCtrl : STD_LOGIC;
    SIGNAL s_oSum : STD_LOGIC_VECTOR(adder_WIDTH - 1 DOWNTO 0);
    SIGNAL s_oCout : STD_LOGIC;

BEGIN

    -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
    -- input or output. Note that DUT0 is just the name of the instance that can be seen 
    -- during simulation. What follows DUT0 is the entity name that will be used to find
    -- the appropriate library component during simulation loading.
    DUT0 : addersubtractor_N
    GENERIC MAP(N => adder_WIDTH)
    PORT MAP(
        i_A => s_iA,
        i_B => s_iB,
        i_Imm => s_iImm,
        i_ALUSrc => S_iALUSrc,
        i_Ctrl => s_iCtrl,
        o_sum => s_osum,
        o_cout => s_ocout
    );

    --You can also do the above port map in one line using the below format: http://www.ics.uci.edu/~jmoorkan/vhdlref/compinst.html

    -- Assign inputs for each test case.
    -- TODO: add test cases as needed.
    Cases : PROCESS
    BEGIN
        WAIT FOR gCLK_HPER/2;
        s_iA <= "00000000000000000000000000000001";
        s_iB <= "00000000000000000000000000000000";
        s_iCtrl <= '0';

        WAIT FOR gCLK_HPER * 2;

        s_iA <= "00000000000000000000000000000111";
        s_iB <= "00000000000000000000000000000001";
        s_iCtrl <= '1';

        WAIT FOR gCLK_HPER * 2;

        s_iA <= "01111111111111111111111111111111";
        s_iB <= "01111111111111111111111111111111";
        s_iALUSrc <= '1';
        s_iImm <= "00000000000000000000000000000001";
        s_iCtrl <= '1';

        WAIT FOR gCLK_HPER * 2;

        s_iA <= "01111111111111111111111111111111";
        s_iB <= "01111111111111111111111111111111";
        s_iImm <= "00000000000000000000000000000001";
        s_iCtrl <= '0';
        s_iALUSrc <= '1';
        WAIT FOR gCLK_HPER * 2;

        WAIT;
    END PROCESS;
END mixed;