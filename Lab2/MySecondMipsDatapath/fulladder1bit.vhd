library IEEE;
use IEEE.std_logic_1164.all;

entity fulladder1bit is
  port(
    i_x1   : in std_logic;
    i_x2   : in std_logic;
    i_cin  : in std_logic := '0'; -- Default value is '0'
    o_sum  : out std_logic;
    o_cout : out std_logic
  );
end fulladder1bit;

architecture structural of fulladder1bit is
  signal x1: std_logic;
  signal a1: std_logic;
  signal a2: std_logic;

  component andg2 is
    port(
      i_A : in std_logic;
      i_B : in std_logic;
      o_F : out std_logic
    );
  end component;

  component org2 is
    port(
      i_A : in std_logic;
      i_B : in std_logic;
      o_F : out std_logic
    );
  end component;

  component xorg2 is
    port(
      i_A : in std_logic;
      i_B : in std_logic;
      o_F : out std_logic
    );
  end component;

begin
  x1 <= i_x1 xor i_x2;
  o_sum <= x1 xor i_cin;
  a1 <= i_x1 and i_x2;
  a2 <= x1 and i_cin;
  o_cout <= a1 or a2;
end structural;
