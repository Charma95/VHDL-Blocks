----------------------------------------------------------------------------------
-- Company: université de Sherbrooke
-- Engineer:  Charles Lévesque-Matte
-- 
-- Create Date: 12/09/2019 08:18:30 PM
-- Design Name: 
-- Module Name: status_signal - Behavioral
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

entity status_signal is
  Port (  
    fifo_full, fifo_empty, fifo_threshold: out std_logic;    
    fifo_overflow, fifo_underflow : out std_logic;    
    wr, rd, fifo_we, fifo_rd,clk,rst_n :in std_logic;  
    wptr, rptr: in  std_logic_vector(4 downto 0)
        );
end status_signal;

architecture Behavioral of status_signal is

 signal fbit_comp, overflow_set, underflow_set: std_logic;
  signal pointer_equal: std_logic;
  signal pointer_result:std_logic_vector(4 downto 0);
  signal full, empty: std_logic;
begin  
 
  fbit_comp <= wptr(4) xor rptr(4);
  pointer_equal <= '1' 

  when (wptr(3 downto 0) = rptr(3 downto 0)) else '0';
    pointer_result <= wptr - rptr;
     overflow_set <= full and wr;
    underflow_set <= empty and rd;
    full <= fbit_comp and  pointer_equal;
    empty <= (not fbit_comp) and  pointer_equal;
    fifo_threshold <=  '1' 

  when (pointer_result(4) or pointer_result(3))='1' else '0';
    fifo_full <= full;
    fifo_empty <= empty;
    
  process(clk,rst_n)
  begin
  if(rst_n='0') then 
    fifo_overflow <= '0';
  elsif(rising_edge(clk)) then 
     if ((overflow_set='1')and (fifo_rd='0')) then 
        fifo_overflow <='1';
    elsif(fifo_rd='1') then 
        fifo_overflow <= '0';
    end if;
  end if;
  end process;
  
  process(clk,rst_n)
  begin
  if(rst_n='0') then  
    fifo_underflow <='0';
  elsif(rising_edge(clk)) then
    if((underflow_set='1')and(fifo_we='0')) then
       fifo_underflow <='1';
    elsif(fifo_we='1') then 
      fifo_underflow <='0';
    end if;
   end if;
  end process;
end Behavioral;
