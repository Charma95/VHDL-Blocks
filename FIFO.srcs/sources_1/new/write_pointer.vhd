----------------------------------------------------------------------------------
-- Company: Université de Sherbrooke
-- Engineer: Charles Lévesque-Matte
--
-- Create Date: 12/09/2019 07:59:08 PM
-- Design Name: FIFO
-- Module Name: write_pointer - Behavioral
-- Project Name: FIFO
-- Target Devices: Zybo Z7-10
-- Tool Versions: Vivado 2018.2
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

Library ieee;
USE ieee.Std_logic_1164.all;
USE ieee.std_logic_arith.all;  
USE ieee.std_logic_unsigned.all; 

entity write_pointer is
    Port ( wptr : out STD_LOGIC_VECTOR (4 downto 0);
           fifo_we : out STD_LOGIC;
           clk : in STD_LOGIC;
           rst_n : in STD_LOGIC;
           wr : in STD_LOGIC;
           fifo_full : in STD_LOGIC);
end write_pointer;

architecture Behavioral of write_pointer is

  signal we: std_logic;
  signal write_addr:std_logic_vector(4 downto 0); 
     
begin  
 fifo_we <= we;
 we <= (not fifo_full) and wr;
 wptr <= write_addr;
 process(clk,rst_n)
 begin 
     if(rst_n = '0') then 
        write_addr <= (others => '0');
     elsif(rising_edge(clk)) then
        if(we = '1') then 
            write_addr <= write_addr + "00001"; 
        end if;
    end if;      
 end process; 
end Behavioral;
