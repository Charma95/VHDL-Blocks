----------------------------------------------------------------------------------
-- Company: Université de Sherbrooke
-- Engineer: Charles Lévesque-Matte
-- 
-- Create Date: 12/09/2019 08:08:38 PM
-- Design Name: 
-- Module Name: read_pointer - Behavioral
-- Project Name: FIFO
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
USE ieee.std_logic_arith.all;  
USE ieee.std_logic_unsigned.all; 


entity read_pointer is
    Port ( rptr : out STD_LOGIC_VECTOR (4 downto 0);
           fifo_rd : out STD_LOGIC;
           clk : in STD_LOGIC;
           rst_n : in STD_LOGIC;
           rd : in STD_LOGIC;
           fifo_empty : in STD_LOGIC);
end read_pointer;

architecture Behavioral of read_pointer is
signal re: std_logic;
signal read_addr:std_logic_vector(4 downto 0);  
  
begin  
 rptr <= read_addr;
 fifo_rd <= re ;
 re <= (not fifo_empty) and rd;
 process(clk,rst_n)
 begin 
     if(rst_n='0') then 
        read_addr <= (others => '0');
     elsif(rising_edge(clk)) then
        if(re='1') then 
            read_addr <= read_addr + "00001"; 
        end if;
    end if;      
 end process;  

end Behavioral;
