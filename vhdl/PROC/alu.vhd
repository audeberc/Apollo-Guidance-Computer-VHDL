library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity parallel_adder is
    Port ( clk : in std_logic;
           a : in std_logic_vector(15 downto 0);
           b : in std_logic_vector(15 downto 0);
           cin : in std_logic;
           s : out std_logic_vector(15 downto 0);
           c : out std_logic
           );
end parallel_adder;

architecture behavior of parallel_adder is

begin
process(clk,a,b,cin)
variable u:std_logic;
begin
  if (clk'event and clk='1') then
    u:=cin;
    for i in 0 to 15 loop
    s(i)<=a(i) xor b(i) xor u;
    u:=(a(i) and b(i))or(b(i) and u) or(u and a(i));
    end loop;
    c<=u;
  end if;
end process;
end behavior;
