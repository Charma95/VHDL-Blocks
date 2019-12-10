----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/09/2019 08:33:03 PM
-- Design Name: 
-- Module Name: memory_array - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
USE IEEE.Std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity memory_array is
 port(
     data_out : out std_logic_vector(7 downto 0);    
  rptr: in  std_logic_vector(4 downto 0);    
     clk :in std_logic;  
  fifo_we: in std_logic;  
     wptr :in  std_logic_vector(4 downto 0);    
  data_in: in std_logic_vector(7 downto 0)
  );
end memory_array;

architecture Behavioral of memory_array is  

type mem_array is array (0 to 15) of std_logic_vector(7 downto 0);
signal data_out2: mem_array;
begin  
    process(clk)
        begin 
        if(rising_edge(clk)) then
            if(fifo_we='1') then 
                data_out2(to_integer(unsigned(wptr(3 downto 0)))) <= data_in; 
            end if;
        end if;      
    end process;  
data_out <= data_out2(to_integer(unsigned(rptr(3 downto 0))));
end Behavioral;
