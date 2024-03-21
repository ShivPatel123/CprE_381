LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY tb_registerfile IS
    GENERIC (gCLK_HPER : TIME := 50 ns);
END tb_registerfile;

ARCHITECTURE behavior OF tb_registerfile IS

    -- Calculate the clock period as twice the half-period
    CONSTANT cCLK_PER : TIME := gCLK_HPER * 2;

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

    -- Temporary signals to connect to the dff component.
    SIGNAL s_rsaddress : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_rtaddress : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_rdaddress : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_rddata : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_rsvalue : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_rtvalue : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_CLK : STD_LOGIC;

BEGIN

    DUT0 : mips_reg_file
    PORT MAP(
        i_CLK => s_CLK,
        i_rsaddress => s_rsaddress,
        i_rtaddress => s_rtaddress,
        i_rdaddress => s_rdaddress,
        i_rddata => s_rddata,
        o_rsvalue => s_rsvalue,
        o_rtvalue => s_rtvalue);

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

        s_rdaddress <= "00000";
        s_rddata <= "01010101010101010101010101010101";

        WAIT FOR cCLK_PER;

        s_rdaddress <= "00001";
        s_rddata <= "00000000000000000000000000000001";

        WAIT FOR cCLK_PER;

        s_rsaddress <= "00000";
        s_rtaddress <= "00001";

        WAIT FOR cCLK_PER;

        WAIT;
    END PROCESS;

END behavior;