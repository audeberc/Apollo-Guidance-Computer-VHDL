library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity full_adder is
    Port (
           X : in std_logic_vector(15 downto 0);
           Y : in std_logic_vector(15 downto 0);
           cin : in std_logic;
           s : out std_logic_vector(15 downto 0);
           c : out std_logic
           );
end full_adder;

architecture behavior of full_adder is

begin
process(X,Y,cin)
variable u:std_logic;
begin
    u:=cin;
    for i in 0 to 15 loop
    s(i)<=X(i) xor Y(i) xor u;
    u:=(X(i) and Y(i))or(Y(i) and u) or(u and X(i));
    end loop;
    c<=u;

end process;
end behavior;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity carry_ff is
    Port ( clk : in std_logic;
           c_in : in std_logic;
           c_out : out std_logic;
           force_in : in std_logic
           );
end carry_ff;

architecture behavior of carry_ff is

begin
process(clk,force_in)
begin
  if RISING_EDGE(clk) then
    c_out <= force_in;
  elsif FALLING_EDGE(clk) then
    c_out <= c_in OR force_in;
  end if;
end process;
end behavior;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity complement_adder is
  Port ( clk : in std_logic;
         X : in std_logic_vector(15 downto 0);
         Y : in std_logic_vector(15 downto 0);
         s : out std_logic_vector(15 downto 0);
         c_in : in std_logic
         );
end complement_adder;


architecture structure of complement_adder is
component full_adder
    Port (
           X : in std_logic_vector(15 downto 0);
           Y : in std_logic_vector(15 downto 0);
           cin : in std_logic;
           s : out std_logic_vector(15 downto 0);
           c : out std_logic
           );
end component;

component carry_ff is
    Port ( clk : in std_logic;
           c_in : in std_logic;
           c_out : out std_logic;
           force_in : in std_logic
           );
end component;

SIGNAL carry_out : std_logic;
SIGNAL carry_in : std_logic;
begin

full_adder_1: full_adder
  port map (X,Y,carry_in,s,carry_out);

carry_ff_1: carry_ff
  port map (clk,carry_out,carry_in,c_in);
end structure;
