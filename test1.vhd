LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY test1 IS
PORT(clk_in:IN STD_LOGIC;
	  clk_out:OUT STD_LOGIC              --输出交通灯系统时钟，5hz
	);
END ENTITY test1;

ARCHITECTURE times OF test1 IS
SIGNAL count1:INTEGER RANGE 4999999 DOWNTO 0;       --计数单位
SIGNAL flag:STD_LOGIC;
BEGIN
fenpin:PROCESS(clk_in,flag)IS
BEGIN
	if(clk_in'EVENT AND CLK_in='1') THEN
		if(count1=4999999) then
			count1<=0;
			flag <= not flag;
		else
			count1<=count1+1;
		end if;
	end if;
		clk_out<=flag;
END PROCESS fenpin;

END ARCHITECTURE times;