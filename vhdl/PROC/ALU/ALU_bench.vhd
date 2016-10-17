library ieee;
use ieee.std_logic_1164.all;

entity tb_ALU is
end tb_ALU;

architecture tb of tb_ALU is

    component ALU
        port (clk     : in std_logic;
              w_bus   : in std_logic_vector (15 downto 0);
              ALU_out : out std_logic_vector (15 downto 0);
              wx      : in std_logic;
              wy      : in std_logic;
              wb      : in std_logic;
              wxy     : in std_logic;
              ci      : in std_logic;
              rb      : in std_logic;
              rc      : in std_logic;
              ru      : in std_logic);
    end component;

    signal clk     : std_logic;
    signal w_bus   : std_logic_vector (15 downto 0);
    signal ALU_out : std_logic_vector (15 downto 0);
    signal wx      : std_logic;
    signal wy      : std_logic;
    signal wb      : std_logic;
    signal wxy     : std_logic;
    signal ci      : std_logic;
    signal rb      : std_logic;
    signal rc      : std_logic;
    signal ru      : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT put right period here
    signal TbClock : std_logic := '0';

begin

    dut : ALU
    port map (clk     => clk,
              w_bus   => w_bus,
              ALU_out => ALU_out,
              wx      => wx,
              wy      => wy,
              wb      => wb,
              wxy     => wxy,
              ci      => ci,
              rb      => rb,
              rc      => rc,
              ru      => ru);

    TbClock <= not TbClock after TbPeriod/2;
    clk <= TbClock;

    stimuli : process
    begin
        -- RESET
        w_bus <= (others => '0');
        wx <= '1';
        wy <= '1';
        wb <= '1';
        wxy <= '1';
        ci <= '1';
        rb <= '1';
        rc <= '1';
        ru <= '1';
        wait for 2*TbPeriod;
        -- WRITE 4 in Y
        w_bus <= "0000000000000100";
        wx <= '1';
        wy <= '0';
        wb <= '1';
        wxy <= '1';
        ci <= '1';
        rb <= '1';
        rc <= '1';
        ru <= '1';
        wait for 2*TbPeriod;
        -- WRITE -2 in X
        w_bus <= "1111111111111101";
        wx <= '0';
        wy <= '1';
        wb <= '1';
        wxy <= '1';
        ci <= '1';
        rb <= '1';
        rc <= '1';
        ru <= '1';

        wait for 2*TbPeriod;
        -- READ RESULT = 2
        w_bus <= "1111111111111101";
        wx <= '1';
        wy <= '1';
        wb <= '1';
        wxy <= '1';
        ci <= '1';
        rb <= '1';
        rc <= '1';
        ru <= '0';

        wait for 2*TbPeriod;
        -- WRITE 18 in B
        w_bus <= x"0012";
        wx <= '1';
        wy <= '1';
        wb <= '0';
        wxy <= '1';
        ci <= '1';
        rb <= '1';
        rc <= '1';
        ru <= '1';
        wait for 2*TbPeriod;
        -- READ B
        w_bus <= x"0012";
        wx <= '1';
        wy <= '1';
        wb <= '1';
        wxy <= '1';
        ci <= '1';
        rb <= '0';
        rc <= '1';
        ru <= '1';
        wait for 2*TbPeriod;
        -- READ C
        w_bus <= x"0012";
        wx <= '1';
        wy <= '1';
        wb <= '1';
        wxy <= '1';
        ci <= '1';
        rb <= '1';
        rc <= '0';
        ru <= '1';
        wait for 2*TbPeriod;

        wait;
    end process;

end tb;

configuration cfg_tb_ALU of tb_ALU is
    for tb
    end for;
end cfg_tb_ALU;
