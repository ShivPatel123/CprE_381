LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY tb_demux5to32 IS
    GENERIC (gCLK_HPER : TIME := 50 ns);
END tb_demux5to32;

ARCHITECTURE behavior OF tb_demux5to32 IS

    -- Calculate the clock period as twice the half-period
    CONSTANT cCLK_PER : TIME := gCLK_HPER * 2;

    CONSTANT WIDTH : INTEGER := 32;

    component demux5to32 IS
    PORT (
        i_in : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        o_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

    END component;

    SIGNAL s_CLK: STD_LOGIC;
    SIGNAL s_in : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_out : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

    DUT0 : demux5to32
    PORT MAP(
        i_in => s_in,
        o_out => s_out);

    -- This process sets the clock value (low for gCLK_HPER, then high
    -- for gCLK_HPER). Absent a "wait" command, processes restart 
    -- at the beginning once they have reached the final statement.
    P_CLK : PROCESS
    BEGIN
        s_CLK <= '0';
        WAIT FOR gCLK_HPER;
        s_CLK <= '1';
        WAIT FOR gCLK_HPER;
    END PROCESS;

    -- Testbench process  
    P_TB : PROCESS
    BEGIN

        s_in <= "00001" ;
        WAIT FOR cCLK_PER;

        s_in <= "10000" ;
        WAIT FOR cCLK_PER;

        s_in <= "11111" ;
        WAIT FOR cCLK_PER;

        s_in <= "00000" ;
        WAIT FOR cCLK_PER;

        s_in <= "00011" ;
        WAIT FOR cCLK_PER;

        WAIT;
    END PROCESS;

END behavior;