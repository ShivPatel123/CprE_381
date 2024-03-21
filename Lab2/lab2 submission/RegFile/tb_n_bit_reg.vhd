LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY tb_n_bit_reg IS
    GENERIC (gCLK_HPER : TIME := 50 ns);
END tb_n_bit_reg;

ARCHITECTURE behavior OF tb_n_bit_reg IS

    -- Calculate the clock period as twice the half-period
    CONSTANT cCLK_PER : TIME := gCLK_HPER * 2;

    CONSTANT WIDTH : INTEGER := 32;

    COMPONENT n_bit_reg IS
        GENERIC (N : INTEGER := 32);
        PORT (
            i_D : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            i_RST : IN STD_LOGIC;
            i_CLK : IN STD_LOGIC;
            i_WE : IN STD_LOGIC;
            o_Q : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
        );
    END COMPONENT;

    -- Temporary signals to connect to the dff component.
    SIGNAL s_CLK, s_RST, s_WE : STD_LOGIC;
    SIGNAL s_D, s_Q : STD_LOGIC_VECTOR(Width - 1 DOWNTO 0);

BEGIN

    DUT0 : n_bit_reg
    GENERIC MAP(N => WIDTH)
    PORT MAP(
        i_CLK => s_CLK,
        i_RST => s_RST,
        i_WE => s_WE,
        i_D => s_D,
        o_Q => s_Q);

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
        -- Reset the FF
        s_RST <= '1';
        s_WE <= '0';
        s_D <= "00000000000000000000000000000000";
        WAIT FOR cCLK_PER;

        -- Store '1'
        s_RST <= '0';
        s_WE <= '1';
        s_D <= "11111111111111111111111111111111";
        WAIT FOR cCLK_PER;

        -- Keep '1'
        s_RST <= '0';
        s_WE <= '0';
        s_D <= "00000000000000000000000000000000";
        WAIT FOR cCLK_PER;

        -- Store '0'    
        s_RST <= '0';
        s_WE <= '1';
        s_D <= "10101010101010101010101010101010";
        WAIT FOR cCLK_PER;

        -- Keep '0'
        s_RST <= '0';
        s_WE <= '0';
        s_D <= "00000000000000000000000000000000";
        WAIT FOR cCLK_PER;

        WAIT;
    END PROCESS;

END behavior;