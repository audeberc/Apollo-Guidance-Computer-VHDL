library ieee;
use ieee.std_logic_1164.all;

entity tb_crg is
end tb_crg;

architecture tb of tb_crg is

    component CRG
        port (clk : in std_logic;
               w_bus : in std_logic_vector(15 downto 0);
               LP_out : out std_logic_vector(15 downto 0);
               A_out : out std_logic_vector(15 downto 0);
               Z_out : out std_logic_vector(15 downto 0);
               Q_out : out std_logic_vector(15 downto 0);
               gen_rst : in std_logic;
               wa : in std_logic;
               wa0 : in std_logic;
               walp : in std_logic;
               wq : in std_logic;
               wa1 : in std_logic;
               wlp : in std_logic;
               wa3 : in std_logic;
               wa2 : in std_logic;
               wz : in std_logic
               );
    end component;

    signal clk     : std_logic;
    signal w_bus   : std_logic_vector (15 downto 0);
    signal LP_out : std_logic_vector (15 downto 0);
    signal A_out : std_logic_vector (15 downto 0);
    signal Z_out : std_logic_vector (15 downto 0);
    signal Q_out : std_logic_vector (15 downto 0);
    signal gen_rst : std_logic;
    signal wa : std_logic;
    signal wa0 : std_logic;
    signal walp : std_logic;
    signal wq : std_logic;
    signal wa1 : std_logic;
    signal wlp : std_logic;
    signal wa3 : std_logic;
    signal wa2 : std_logic;
    signal wz : std_logic;
    constant TbPeriod : time := 1000 ns; -- EDIT put right period here
    signal TbClock : std_logic := '0';

begin

    dut : crg
    port map (clk => clk,
           w_bus => w_bus,
           LP_out => LP_out,
           A_out => A_out,
           Z_out => Z_out,
           Q_out => Q_out,
           gen_rst => gen_rst,
           wa => wa,
           wa0 => wa0,
           walp => walp,
           wq => wq,
           wa1 => wa1,
           wlp => wlp,
           wa3 => wa3,
           wa2 => wa2,
           wz =>wz);

    TbClock <= not TbClock after TbPeriod/2;
    clk <= TbClock;

    stimuli : process
    begin
        -- RESET
        gen_rst <='0';
        w_bus <= (others => '0');
        wa <= '1';
        wa0 <= '1';
        walp <= '1';
        wq <= '1';
        wa1 <= '1';
        wlp <= '1';
        wa3 <= '1';
        wa2 <= '1';
        wz <= '1';
        wait for TbPeriod;
        -- write A
        gen_rst <='1';
        w_bus <= "0011010101001001";
        wa <= '0';
        wa0 <= '1';
        walp <= '1';
        wq <= '1';
        wa1 <= '1';
        wlp <= '1';
        wa3 <= '1';
        wa2 <= '1';
        wz <= '1';
        wait for TbPeriod;
        -- write A agai
        gen_rst <='1';
        w_bus <= "0011010001001001";
        wa <= '1';
        wa0 <= '0';
        walp <= '1';
        wq <= '1';
        wa1 <= '1';
        wlp <= '1';
        wa3 <= '1';
        wa2 <= '1';
        wz <= '1';
        wait for TbPeriod;
        -- write shift A
        gen_rst <='1';
        w_bus <= "0000110001001001";
        wa <= '1';
        wa0 <= '1';
        walp <= '0';
        wq <= '1';
        wa1 <= '1';
        wlp <= '1';
        wa3 <= '1';
        wa2 <= '1';
        wz <= '1';
        wait for TbPeriod;
        -- write Z
        gen_rst <='1';
        w_bus <= "0000110001001001";
        wa <= '1';
        wa0 <= '1';
        walp <= '1';
        wq <= '0';
        wa1 <= '1';
        wlp <= '1';
        wa3 <= '1';
        wa2 <= '1';
        wz <= '1';
        wait for TbPeriod;
        -- write Z again
        gen_rst <='1';
        w_bus <= "0000000001111001";
        wa <= '1';
        wa0 <= '1';
        walp <= '1';
        wq <= '1';
        wa1 <= '0';
        wlp <= '1';
        wa3 <= '1';
        wa2 <= '1';
        wz <= '1';
        wait for TbPeriod;
        -- write LP shift
        gen_rst <='1';
        w_bus <= "0000110001001101";
        wa <= '1';
        wa0 <= '1';
        walp <= '1';
        wq <= '1';
        wa1 <= '1';
        wlp <= '0';
        wa3 <= '1';
        wa2 <= '1';
        wz <= '1';
        wait for TbPeriod;
        -- write  shift LP ,
        gen_rst <='1';
        w_bus <= "0000010001001001";
        wa <= '1';
        wa0 <= '1';
        walp <= '1';
        wq <= '1';
        wa1 <= '1';
        wlp <= '1';
        wa3 <= '0';
        wa2 <= '1';
        wz <= '1';
        wait for TbPeriod;
        -- write Z
        gen_rst <='1';
        w_bus <= "00000001001001";
        wa <= '1';
        wa0 <= '1';
        walp <= '1';
        wq <= '1';
        wa1 <= '1';
        wlp <= '1';
        wa3 <= '1';
        wa2 <= '0';
        wz <= '1';
        wait for TbPeriod;
        -- write Z
        gen_rst <='1';
        w_bus <= "00011101001001";
        wa <= '1';
        wa0 <= '1';
        walp <= '1';
        wq <= '1';
        wa1 <= '1';
        wlp <= '1';
        wa3 <= '1';
        wa2 <= '1';
        wz <= '0';
        wait for TbPeriod;

        wait;
    end process;

end tb;

configuration cfg_tb_crg of tb_crg is
    for tb
    end for;
end cfg_tb_crg;
