library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( clk : in std_logic;
           wx : in std_logic;
           wy : in std_logic;
           wb : in std_logic;
           ci : in std_logic;
           rb : out std_logic;
           rc : out std_logic;
           ru : out std_logic;
           X : out std_logic_vector(15 downto 0);
           Y : out std_logic_vector(15 downto 0);
           U : in std_logic_vector(15 downto 0);
           B_in : in std_logic_vector(15 downto 0);
           B_out : out std_logic_vector(15 downto 0);
           cin : in std_logic;
           s : out std_logic_vector(15 downto 0);
           c : out std_logic
           );
end ALU;

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
