LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY tb_mux32to1 IS
    GENERIC (gCLK_HPER : TIME := 50 ns);
END tb_mux32to1;

ARCHITECTURE behavior OF tb_mux32to1 IS

    -- Calculate the clock period as twice the half-period
    CONSTANT cCLK_PER : TIME := gCLK_HPER * 2;

    COMPONENT mux32to1 IS
        PORT (
            i_S : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            i_D0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D4 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D5 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D6 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D7 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D8 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D9 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D10 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D11 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D12 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D13 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D14 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D15 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D16 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D17 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D18 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D19 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D20 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D21 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D22 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D23 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D24 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D25 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D26 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D27 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D28 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D29 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D30 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_D31 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_O : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));

    END COMPONENT;

    -- Temporary signals to connect to the dff component.
    SIGNAL s_S : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_D0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D3 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D4 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D5 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D6 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D7 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D8 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D9 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D10 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D11 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D12 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D13 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D14 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D15 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D16 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D17 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D18 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D19 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D20 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D21 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D22 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D23 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D24 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D25 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D26 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D27 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D28 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D29 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D30 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_D31 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_O : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_CLK : STD_LOGIC;

BEGIN

    DUT0 : mux32to1
    PORT MAP(
        i_S => s_S,
        i_D0 => s_D0,
        i_D1 => s_D1,
        i_D2 => s_D2,
        i_D3 => s_D3,
        i_D4 => s_D4,
        i_D5 => s_D5,
        i_D6 => s_D6,
        i_D7 => s_D7,
        i_D8 => s_D8,
        i_D9 => s_D9,
        i_D10 => s_D10,
        i_D11 => s_D11,
        i_D12 => s_D12,
        i_D13 => s_D13,
        i_D14 => s_D14,
        i_D15 => s_D15,
        i_D16 => s_D16,
        i_D17 => s_D17,
        i_D18 => s_D18,
        i_D19 => s_D19,
        i_D20 => s_D20,
        i_D21 => s_D21,
        i_D22 => s_D22,
        i_D23 => s_D23,
        i_D24 => s_D24,
        i_D25 => s_D25,
        i_D26 => s_D26,
        i_D27 => s_D27,
        i_D28 => s_D28,
        i_D29 => s_D29,
        i_D30 => s_D30,
        i_D31 => s_D31,
        o_O => s_O);

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
        s_S <= "00000";
        s_D0 <= "11111111111111111111111111111111";

        s_D3 <= "01111111111111111111111111111110";

        s_D31 <= "10101010101010101010101010101010";

        WAIT FOR cCLK_PER;

        s_S <= "11111";
        WAIT FOR cCLK_PER;

        s_S <= "00011";
        WAIT FOR cCLK_PER;

        WAIT;
    END PROCESS;

END behavior;