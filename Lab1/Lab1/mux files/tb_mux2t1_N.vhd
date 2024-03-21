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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O



-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_mux2t1_N is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle perioda
end tb_mux2t1_N;

architecture mixed of tb_mux2t1_N is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.

constant MUX2t1_WIDTH : integer := 3;


component mux2t1_N is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

-- TODO: change input and output signals as needed.
signal s_iS   : std_logic;
signal s_iD0   : std_logic_vector(MUX2t1_WIDTH-1 downto 0);
signal s_iD1 : std_logic_vector(MUX2t1_WIDTH-1 downto 0);
signal s_oO   : std_logic_vector(MUX2t1_WIDTH-1 downto 0);

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: mux2t1_N
  generic map(N => MUX2t1_WIDTH)
  port map(
            i_S     => s_iS,
            i_D0     => s_iD0,
            i_D1     => s_iD1,
            o_O     => s_oO
          );

  --You can also do the above port map in one line using the below format: http://www.ics.uci.edu/~jmoorkan/vhdlref/compinst.html


  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  Cases: process
  begin
    wait for gCLK_HPER/2;  
  

    s_iS   <= '0';
    s_iD0  <= "010";  
    s_iD1  <= "101"; 
    wait for gCLK_HPER*2; 
  

    s_iS   <= '1';
    s_iD0  <= "010";
    s_iD1  <= "101";
    wait for gCLK_HPER*2; 

  
    wait;
  end process;


end mixed;