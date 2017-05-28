LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY jishu1 IS
	PORT(
		clkjishu: IN STD_LOGIC;
		ens:       IN STD_LOGIC;
		light_state: IN INTEGER RANGE 2 DOWNTO 0;
		light:    OUT INTEGER RANGE 50 DOWNTO 0;
		num:      OUT INTEGER RANGE 60 DOWNTO 0
	);
END jishu1;

ARCHITECTURE example OF jishu1 IS
SIGNAL sec_g:INTEGER RANGE 29 DOWNTO 0:=29;
SIGNAL sec_r:INTEGER RANGE 14 DOWNTO 0:=14;
SIGNAL sec_y:INTEGER RANGE 2  DOWNTO 0:=2;
SIGNAL flag: STD_LOGIC:='1';
SIGNAL count:INTEGER RANGE 2 DOWNTO 0;
BEGIN
	process(clkjishu)
	VARIABLE sec  :INTEGER RANGE 30 DOWNTO 0;
	VARIABLE light1:INTEGER RANGE 50 DOWNTO 0:=14;
	BEGIN
		if(clkjishu'event and clkjishu='1') then
			if(ens='1')then
				sec:=29;
			elsif(light_state=0)then               -------------车绿人红-----------
				light1 :=14;
				sec := sec_g;
				if(sec_g=0)then
					sec_g<=29;
				else
					sec_g<=sec_g-1;
				end if;
				
			elsif(light_state=1)then            -------------车红人绿-----------
				light1 :=41;
				sec := sec_r;
				if(sec_r=0)then
					sec_r<=14;
				else
					sec_r<=sec_r-1;
				end if;
				
			elsif(light_state=2)then              -------------车黄人红-----------
				light1 :=24;
				sec := sec_y;
				if(sec_y=0)then
					sec_y<=2;
				else
					sec_y<=sec_y-1;
				end if;
			end if;
			
		light <= light1;
		num   <= sec;
		
		end if;
		

	END PROCESS;
END ARCHITECTURE example;