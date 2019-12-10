----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/09/2019 08:36:59 PM
-- Design Name: 
-- Module Name: FIFO - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;


entity FIFO is
    port(
      data_out : out std_logic_vector(7 downto 0);    
      fifo_full, fifo_empty, fifo_threshold, 

      fifo_overflow, fifo_underflow: out std_logic;
      clk :in std_logic;  
      rst_n: in std_logic;  
      wr :in  std_logic;
      rd: in std_logic;
      data_in: in std_logic_vector(7 downto 0)
         );
    end FIFO;

architecture Behavioral of FIFO is

component write_pointer 
   port(
      wptr : out std_logic_vector(4 downto 0);    
	  fifo_we: out std_logic;
      clk :in std_logic;  
      rst_n: in std_logic;  
      wr :in  std_logic;
      fifo_full: in std_logic
   );
end component;

component read_pointer
   port(
      rptr : out std_logic_vector(4 downto 0);    
      fifo_rd: out std_logic;
      clk :in std_logic;  
      rst_n: in std_logic;  
      rd :in  std_logic;
      fifo_empty: in std_logic
   );
end component;

component memory_array
   port(
      data_out : out std_logic_vector(7 downto 0);    
   rptr: in  std_logic_vector(4 downto 0);    
      clk :in std_logic;  
   fifo_we: in std_logic;  
      wptr :in  std_logic_vector(4 downto 0);    
   data_in: in std_logic_vector(7 downto 0)
   );
end component;

component status_signal
   port(
      fifo_full, fifo_empty, fifo_threshold: out std_logic;    
   fifo_overflow, fifo_underflow : out std_logic;    
      wr, rd, fifo_we, fifo_rd,clk,rst_n :in std_logic;  
      wptr, rptr: in  std_logic_vector(4 downto 0)
   );
end component;

  signal empty, full: std_logic;    
  signal wptr,rptr: std_logic_vector(4 downto 0);
  signal fifo_we,fifo_rd: std_logic;    
begin  

 write_pointer_unit: write_pointer port map 
      (   
       wptr => wptr, 
       fifo_we=> fifo_we, 
       wr=> wr,  
       fifo_full => full,
       clk => clk,
       rst_n => rst_n
      );
	  
 read_pointer_unit: read_pointer port map 
      (
       rptr => rptr,
       fifo_rd => fifo_rd,
       rd => rd ,
       fifo_empty => empty,
       clk => clk,
       rst_n => rst_n
      );
	  
 memory_array_unit: memory_array port map 
      (
       data_out => data_out,
       data_in => data_in,
       clk => clk,
       fifo_we => fifo_we,
       wptr => wptr,
       rptr => rptr
      );
	  
 status_signal_unit: status_signal port map 
      (
       fifo_full => full,
       fifo_empty => empty,
       fifo_threshold => fifo_threshold,
       fifo_overflow => fifo_overflow, 
       fifo_underflow => fifo_underflow,
       wr => wr, 
       rd => rd, 
       fifo_we => fifo_we,
       fifo_rd => fifo_rd,
       wptr => wptr,
       rptr => rptr,
       clk => clk,
       rst_n => rst_n
      );
	  
 fifo_empty <= empty;
 fifo_full <= full;

end Behavioral;
