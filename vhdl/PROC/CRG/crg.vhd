library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CRG is
    Port ( clk : in std_logic;
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
end CRG;

architecture behavior of CRG is

begin
process(clk)
begin
  if (clk'event and clk='1') then
    if (gen_rst = '0') then -- General reset
      LP_out <= (others => '0');
      Z_out <= (others => '0');
      Q_out <= (others => '0');
    else

-- A reg
      if ( wa = '0' or wa0 = '0') then
        A_out <= w_bus;
      elsif (walp = '0') then -- shifting into A
        A_out(15) <= w_bus(15);-- SG
        A_out(14) <= w_bus(15);-- SG
        A_out(13) <= w_bus(14);-- US
        A_out(12) <= w_bus(13);
        A_out(11) <= w_bus(12);
        A_out(10) <= w_bus(11);
        A_out(9) <= w_bus(10);
        A_out(8) <= w_bus(9);
        A_out(7) <= w_bus(8);
        A_out(6) <= w_bus(7);
        A_out(5) <= w_bus(6);
        A_out(4) <= w_bus(5);
        A_out(3) <= w_bus(4);
        A_out(2) <= w_bus(3);
        A_out(1) <= w_bus(2);
        A_out(0) <= w_bus(1);
      end if;

-- LP reg
      if ( wlp = '0' or wa3 = '0') then
        LP_out(15) <= w_bus(0);-- LSB -> MSB
        LP_out(14) <= w_bus(0);--
      --  LP_out(13) <= w_bus(14);-- US
        LP_out(12) <= w_bus(13);
        LP_out(11) <= w_bus(12);
        LP_out(10) <= w_bus(11);
        LP_out(9) <= w_bus(10);
        LP_out(8) <= w_bus(9);
        LP_out(7) <= w_bus(8);
        LP_out(6) <= w_bus(7);
        LP_out(5) <= w_bus(6);
        LP_out(4) <= w_bus(5);
        LP_out(3) <= w_bus(4);
        LP_out(2) <= w_bus(3);
        LP_out(1) <= w_bus(2);
        LP_out(0) <= w_bus(1);
      end if;
      if( walp = '0' or wlp = '0' or wa3 = '0') then
        LP_out(13) <= not(walp or not(w_bus(0)));
      end if;
 -- Z reg
      if ( wz = '0' or wa2 = '0') then
        Z_out <= w_bus;
      end if;
 -- Q reg
       if ( wq = '0' or wa1 = '0') then
         Z_out <= w_bus;
       end if;

    end if; -- reset if
  end if; -- clk if
end process;

end behavior;
