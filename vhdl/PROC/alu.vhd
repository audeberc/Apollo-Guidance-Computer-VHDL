library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
  Port ( clk : in std_logic;
         w_bus : in std_logic_vector(15 downto 0);
         ALU_out : out std_logic_vector(15 downto 0);
         wx : in std_logic;
         wy : in std_logic;
         wb : in std_logic;
         wxy : in std_logic;
         ci : in std_logic;
         rb : in std_logic;
         rc : in std_logic;
         ru : in std_logic
         );
end ALU;


architecture structure of ALU is

 component complement_adder
   Port ( clk : in std_logic;
          X : in std_logic_vector(15 downto 0);
          Y : in std_logic_vector(15 downto 0);
          s : out std_logic_vector(15 downto 0);
          c_in : in std_logic
          );
 end component;

component ALU_reg
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
end component;

signal x_sig : std_logic_vector(15 downto 0);
signal y_sig : std_logic_vector(15 downto 0);
signal u_sig : std_logic_vector(15 downto 0);
signal c_sig : std_logic;
begin

adder_1: complement_adder
  port map (clk,x_sig,y_sig,u_sig,c_sig);

ALU_reg_1: ALU_reg
  port map (clk,wx,wy,wb,wxy,ci,rb,rc,ru,x_sig,y_sig,c_sig,u_sig,w_bus,ALU_out);
end structure;
