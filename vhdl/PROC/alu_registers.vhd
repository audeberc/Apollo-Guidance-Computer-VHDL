library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_reg is
    Port ( clk : in std_logic;
           wx : in std_logic;
           wy : in std_logic;
           wb : in std_logic;
           wxy : in std_logic;
           ci : in std_logic;
           rb : in std_logic;
           rc : in std_logic;
           ru : in std_logic;
           x_add : out std_logic_vector(15 downto 0);
           y_add : out std_logic_vector(15 downto 0);
           c_force_add : out std_logic;
           u_add : in std_logic_vector(15 downto 0);

           w_bus : in std_logic_vector(15 downto 0);
           ALU_out : out std_logic_vector(15 downto 0)
           );
end ALU_reg;

architecture behavior of ALU_reg is
  signal B : std_logic_vector(15 downto 0);

  signal F : std_logic_vector(15 downto 0);
  signal U : std_logic_vector(15 downto 0);

begin
process(clk)

--	RB	RC	RU	 Func
--  0  0  0   A
--  0  0  1   A
--  0  1  0   A
--  0  1  1   A
--  1  0  0  !A + B
--  1  0  1  !A
--  1  1  0   B
--  1  1  1   Logic 0
-- --------------------------------------------------------------------
begin
  if (clk'event and clk='1') then
    if wb = '0' then
      B <= w_bus;
    end if;

    if (wy = '0' or wxy = '0') then
      y_add <= w_bus;
    end if;

    if (wy) = '0' then
      x_add <= (others => '0');
    elsif (wx = '0')
      x_add <= w_bus;
    end if;

    if (ci = '1' and wy = '0') then
      c_force_add <= '0';
    elsif (ci = '0')
      c_force_add <= '1';
    end if;
  end if;
end process;

process(rb,rc,ru,u_add,w_bus)
variable ctrl : std_logic_vector(2 downto 0);
begin
ctrl := rb & rc & ru;
case ctrl is
  when "000" => ALU_out <= B;
  when "001" => ALU_out <= B;
  when "010" => ALU_out <= B;
  when "011" => ALU_out <= B;
  when "100" => ALU_out <= (not B) OR u_add;
  when "101" => ALU_out <= not B;
  when "110" => ALU_out <= u_add;
  when "111" => ALU_out <= (others=>'0');
end case;
end process;
end behavior;
