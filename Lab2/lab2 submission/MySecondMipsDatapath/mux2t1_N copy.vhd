-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- mux2t1_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 1/6/20 by H3::Created.
-------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux2t1_N IS
  GENERIC (N : INTEGER := 32); -- Generic of type integer for input/output data width. Default value is 32.
  PORT (
    i_S : IN STD_LOGIC;
    i_D0 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    i_D1 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    o_O : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0));

END mux2t1_N;

ARCHITECTURE structural OF mux2t1_N IS

  COMPONENT mux2t1 IS
    PORT (
      i_S : IN STD_LOGIC;
      i_D0 : IN STD_LOGIC;
      i_D1 : IN STD_LOGIC;
      o_O : OUT STD_LOGIC);
  END COMPONENT;

BEGIN

  -- Instantiate N mux instances.
  G_NBit_MUX : FOR i IN 0 TO N - 1 GENERATE
    MUXI : mux2t1 PORT MAP(
      i_S => i_S, -- All instances share the same select input.
      i_D0 => i_D0(i), -- ith instance's data 0 input hooked up to ith data 0 input.
      i_D1 => i_D1(i), -- ith instance's data 1 input hooked up to ith data 1 input.
      o_O => o_O(i)); -- ith instance's data output hooked up to ith data output.
  END GENERATE G_NBit_MUX;

END structural;