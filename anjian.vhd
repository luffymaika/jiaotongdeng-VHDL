LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY anjian IS
PORT( 
	clkaj,keyin:IN STD_LOGIC;
	keyout: OUT  STD_LOGIC
);
end entity anjian;

ARCHITECTURE aj OF anjian IS
SIGNAL count1 :INTEGER RANGE 1000000 DOWNTO 0;
SIGNAL a      :STD_LOGIC;
BEGIN
PROCESS(clkaj)
begin
	if(keyin='0')then
		count1<=0;
	elsif(rising_edge(clkaj))then
		if(count1=1000000)then
			count1<=count1;
		else
			count1<=count1+1;
		end if;
	end if;
	
	if(count1>100000)then
		a<='0';
	else
		a<='1';
	end if;
	keyout<=a;
end proCESS;
end arcHITECTURE aj;