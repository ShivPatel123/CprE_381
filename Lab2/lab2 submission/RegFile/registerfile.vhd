LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mips_reg_file IS
    PORT (
        i_CLK : IN STD_LOGIC;
        i_rsaddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        i_rtaddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        i_rdaddress : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        i_rddata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_rsvalue : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_rtvalue : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

END mips_reg_file;

ARCHITECTURE structural OF mips_reg_file IS

    COMPONENT mux32to1 IS
        PORT (
            i_S : IN STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
            i_D0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D4 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D5 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D6 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D7 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D8 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D9 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D10 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D11 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D12 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D13 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D14 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D15 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D16 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D17 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D18 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D19 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D20 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D21 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D22 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D23 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D24 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D25 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D26 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D27 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D28 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D29 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D30 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            i_D31 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
            o_O : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000");
    END COMPONENT;

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

    COMPONENT demux5to32 IS
        PORT (
            i_in : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            o_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );

    END COMPONENT;

    SIGNAL rdAddressOut : STD_LOGIC_VECTOR(31 DOWNTO 0);

    TYPE bus_t IS ARRAY(31 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL mux_bus : bus_t;

BEGIN

    demux : demux5to32 PORT MAP(
        i_in => i_rdaddress,
        o_out => rdAddressOut
    );

    rsmux : mux32to1 PORT MAP(
        i_S => i_rsaddress,
        o_O => o_rsvalue,
        i_D0 => mux_bus(0),
        i_D1 => mux_bus(1),
        i_D2 => mux_bus(2),
        i_D3 => mux_bus(3),
        i_D4 => mux_bus(4),
        i_D5 => mux_bus(5),
        i_D6 => mux_bus(6),
        i_D7 => mux_bus(7),
        i_D8 => mux_bus(8),
        i_D9 => mux_bus(9),
        i_D10 => mux_bus(10),
        i_D11 => mux_bus(11),
        i_D12 => mux_bus(12),
        i_D13 => mux_bus(13),
        i_D14 => mux_bus(14),
        i_D15 => mux_bus(15),
        i_D16 => mux_bus(16),
        i_D17 => mux_bus(17),
        i_D18 => mux_bus(18),
        i_D19 => mux_bus(19),
        i_D20 => mux_bus(20),
        i_D21 => mux_bus(21),
        i_D22 => mux_bus(22),
        i_D23 => mux_bus(23),
        i_D24 => mux_bus(24),
        i_D25 => mux_bus(25),
        i_D26 => mux_bus(26),
        i_D27 => mux_bus(27),
        i_D28 => mux_bus(28),
        i_D29 => mux_bus(29),
        i_D30 => mux_bus(30),
        i_D31 => mux_bus(31)
    );

    rtmux : mux32to1 PORT MAP(
        i_S => i_rtaddress,
        o_O => o_rtvalue,
        i_D0 => mux_bus(0),
        i_D1 => mux_bus(1),
        i_D2 => mux_bus(2),
        i_D3 => mux_bus(3),
        i_D4 => mux_bus(4),
        i_D5 => mux_bus(5),
        i_D6 => mux_bus(6),
        i_D7 => mux_bus(7),
        i_D8 => mux_bus(8),
        i_D9 => mux_bus(9),
        i_D10 => mux_bus(10),
        i_D11 => mux_bus(11),
        i_D12 => mux_bus(12),
        i_D13 => mux_bus(13),
        i_D14 => mux_bus(14),
        i_D15 => mux_bus(15),
        i_D16 => mux_bus(16),
        i_D17 => mux_bus(17),
        i_D18 => mux_bus(18),
        i_D19 => mux_bus(19),
        i_D20 => mux_bus(20),
        i_D21 => mux_bus(21),
        i_D22 => mux_bus(22),
        i_D23 => mux_bus(23),
        i_D24 => mux_bus(24),
        i_D25 => mux_bus(25),
        i_D26 => mux_bus(26),
        i_D27 => mux_bus(27),
        i_D28 => mux_bus(28),
        i_D29 => mux_bus(29),
        i_D30 => mux_bus(30),
        i_D31 => mux_bus(31)
    );

    G_NBit_DFFG : FOR i IN 0 TO 31 GENERATE
        registers : n_bit_reg PORT MAP(
            i_D => i_rddata,
            i_RST => '0',
            i_CLK => i_CLK,
            i_WE => rdAddressOut(i),
            o_Q => mux_bus(i));
    END GENERATE G_NBit_DFFG;

END structural;