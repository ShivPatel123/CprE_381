LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY n_bit_reg IS
  GENERIC (N : INTEGER := 32);
  PORT (
    i_D : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    i_RST : IN STD_LOGIC;
    i_CLK : IN STD_LOGIC;
    i_WE : IN STD_LOGIC;
    o_Q : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
  );

END n_bit_reg;

ARCHITECTURE structural OF n_bit_reg IS
  COMPONENT dffg
    PORT (
      i_CLK : IN STD_LOGIC; -- Clock input
      i_RST : IN STD_LOGIC; -- Reset input
      i_WE : IN STD_LOGIC; -- Write enable input
      i_D : IN STD_LOGIC; -- Data value input
      o_Q : OUT STD_LOGIC); -- Data value output
  END COMPONENT;
BEGIN

  -- Instantiate N dffg instances.
  G_NBit_DFFG : FOR i IN 0 TO N - 1 GENERATE
    dffgcomponent : dffg PORT MAP(
      i_CLK => i_CLK, -- All instances share the same select input.
      i_RST => i_RST,
      i_WE => i_WE,
      i_D => i_D(i), -- ith instance's data input hooked up to i-1th data  output.
      o_Q => o_Q(i)); -- ith instance's data output hooked up to ith data output.
  END GENERATE G_NBit_DFFG;
END structural;