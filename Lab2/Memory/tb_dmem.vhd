LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY tb_dmem IS
    GENERIC (gCLK_HPER : TIME := 50 ns);
END tb_dmem;

ARCHITECTURE behavior OF tb_dmem IS

    -- Calculate the clock period as twice the half-period
    CONSTANT cCLK_PER : TIME := gCLK_HPER * 2;

    CONSTANT WIDTH : INTEGER := 32;

    CONSTANT DATA_WIDTH : NATURAL := 32;
    CONSTANT ADDR_WIDTH : NATURAL := 10;

    COMPONENT mem IS

        GENERIC (
            DATA_WIDTH : NATURAL := 32;
            ADDR_WIDTH : NATURAL := 10
        );

        PORT (
            clk : IN STD_LOGIC;
            addr : IN STD_LOGIC_VECTOR((ADDR_WIDTH - 1) DOWNTO 0);
            data : IN STD_LOGIC_VECTOR((DATA_WIDTH - 1) DOWNTO 0);
            we : IN STD_LOGIC := '1';
            q : OUT STD_LOGIC_VECTOR((DATA_WIDTH - 1) DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL s_clk : STD_LOGIC;
    SIGNAL s_addr : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
    SIGNAL s_data : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL s_we : STD_LOGIC;
    SIGNAL s_q : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

BEGIN

    dmem : mem
    PORT MAP(
        clk => s_clk,
        addr => s_addr,
        data => s_data,
        we => s_we,
        q => s_q);

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
        s_we <= '0';
        s_addr <= "0000000000";
        WAIT FOR cCLK_PER;
        s_data <= s_q;
        s_we <= '1';
        s_addr <= "0100000000";
        WAIT FOR cCLK_PER;

        s_we <= '0';
        s_addr <= "0000000001";
        WAIT FOR cCLK_PER;
        s_data <= s_q;
        s_we <= '1';
        s_addr <= "0100000001";
        WAIT FOR cCLK_PER;

        s_we <= '0';
        s_addr <= "0000000010";
        WAIT FOR cCLK_PER;
        s_data <= s_q;
        s_we <= '1';
        s_addr <= "0100000010";
        WAIT FOR cCLK_PER;

        s_we <= '0';
        s_addr <= "0000000011";
        WAIT FOR cCLK_PER;
        s_data <= s_q;
        s_we <= '1';
        s_addr <= "0100000011";
        WAIT FOR cCLK_PER;

        s_we <= '0';
        s_addr <= "0000000100";
        WAIT FOR cCLK_PER;
        s_data <= s_q;
        s_we <= '1';
        s_addr <= "0100000100";
        WAIT FOR cCLK_PER;

        s_we <= '0';
        s_addr <= "0000000101";
        WAIT FOR cCLK_PER;
        s_data <= s_q;
        s_we <= '1';
        s_addr <= "0100000101";
        WAIT FOR cCLK_PER;

        s_we <= '0';
        s_addr <= "0000000110";
        WAIT FOR cCLK_PER;
        s_data <= s_q;
        s_we <= '1';
        s_addr <= "0100000110";
        WAIT FOR cCLK_PER;

        s_we <= '0';
        s_addr <= "0000000111";
        WAIT FOR cCLK_PER;
        s_data <= s_q;
        s_we <= '1';
        s_addr <= "0100000111";
        WAIT FOR cCLK_PER;

        s_we <= '0';
        s_addr <= "0000001000";
        WAIT FOR cCLK_PER;
        s_data <= s_q;
        s_we <= '1';
        s_addr <= "0100001000";
        WAIT FOR cCLK_PER;

        s_we <= '0';
        s_addr <= "0000001001";
        WAIT FOR cCLK_PER;
        s_data <= s_q;
        s_we <= '1';
        s_addr <= "0100001001";
        WAIT FOR cCLK_PER;

        s_we <= '0';
        s_addr <= "0000001010";
        WAIT FOR cCLK_PER;
        s_data <= s_q;
        s_we <= '1';
        s_addr <= "0100001010";
        WAIT FOR cCLK_PER;

        WAIT;
    END PROCESS;

END behavior;