LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
	ENTITY test2 IS
PORT(clk_in2:IN STD_LOGIC;
--	  Ncount:IN INTEGER RANGE 60 DOWNTO 0;
	  clk_out2:OUT STD_LOGIC               --输出显示频率，500hz
	  );
END ENTITY test2;

ARCHITECTURE times OF test2 IS
SIGNAL count1:INTEGER RANGE 49999 DOWNTO 0;       --计数单位
SIGNAL led_outdata: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL flag:STD_LOGIC;
BEGIN
fenpin:PROCESS(clk_in2,flag)IS
BEGIN
	if(clk_in2'EVENT AND CLK_in2='1') THEN
		if(count1=2) then
			count1<=0;
			flag <= not flag;
		else
			count1<=count1+1;
		end if;
	end if;
		clk_out2 <=flag;
END PROCESS fenpin;

END ARCHITECTURE times;