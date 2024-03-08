-------------------------------------------------------------------------
-- Shivansh
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of two input mux. 
--
--
-- NOTES: Integer data type is not typically useful when doing hardware
-- design. We use it here for simplicity, but in future labs it will be
-- important to switch to std_logic_vector types and associated math
-- libraries (e.g. signed, unsigned). 


-- 1/25/24
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity dataflowmux2t1 is

  port(i_S             : in std_logic;
       i_D0               : in std_logic;
       i_D1               : in std_logic;
       o_O               : out std_logic);

end dataflowmux2t1;

architecture dataflow of dataflowmux2t1 is
begin
  o_O <= i_D0 when (i_S = '0') else
    i_D1 when (i_S = '1') else
    '0';
end dataflow;