LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY top IS
	PORT(
		clk,key1,key2,key3,key4,key5: IN STD_LOGIC;
		seg7data:	OUT STD_LOGIC_VECTOR(7 downto 0);
		seg7com: OUT STD_LOGIC_VECTOR(3 downto 0)
		);
END top;

ARCHITECTURE example OF top IS
	
	COMPONENT test1 IS----------------------分频器1，5 hz-----------
		PORT (
			clk_in:IN STD_LOGIC;
			clk_out:OUT STD_LOGIC
		);
	END COMPONENT test1;
	
	COMPONENT test2 IS----------------------分频器2：500 hz----------------
		PORT (
			clk_in2 :IN STD_LOGIC;
			clk_out2 :OUT STD_LOGIC
		);
	END COMPONENT test2;
		
	
	COMPONENT xianshi IS-------------------显示模块------------------------
		PORT (
			clk1: IN STD_LOGIC;
			num: IN INTEGER RANGE 99 DOWNTO 0; 
			light: IN INTEGER RANGE 50 DOWNTO 0;
			ledcom: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			leddata:OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT xianshi;
	
	
	SIGNAL clk_jishu:STD_LOGIC;                    --计数用频率
	SIGNAL key_out:STD_LOGIC:='1';               ----按键信息
	SIGNAL clk_saomiao:STD_LOGIC;                  --扫描用频率
	SIGNAL sec_g:INTEGER RANGE 29 DOWNTO 0:=29;    --绿灯持续时间
	SIGNAL sec_r:INTEGER RANGE 14 DOWNTO 0:=14;
	SIGNAL sec_y:INTEGER RANGE 2  DOWNTO 0:=2;
	SIGNAL count1 :INTEGER RANGE 0 TO 500000:=0;    --按键所需持续时间；
--	SIGNAL count2 :INTEGER RANGE 0 TO 500000:=0;
	SIGNAL pre_state:INTEGER RANGE 2 DOWNTO 0:=0;---------------0:车绿人红  1:车红人绿  2：车黄人红；-----------------
	SIGNAL next_state:INTEGER RANGE 2 DOWNTO 0:=0; 
	SIGNAL lightstate:INTEGER RANGE 2 DOWNTO 0:=0;  --路灯状况 0:车绿人红  1:车红人绿  2：车黄人红 
	SIGNAL lightdata :INTEGER RANGE 50 DOWNTO 0;    --路灯显示数据
	SIGNAL secnum  :INTEGER RANGE 60 DOWNTO 0;
	SIGNAL flag :STD_LOGIC:='1';
	
BEGIN
	
	HELLO: test1 PORT MAP(
			clk_in => clk,
			clk_out => clk_jishu  ------------输出计数频率5 hz
			);
			
	HELLo2: test2 PORT MAP(
		clk_in2 => clk,
		clk_out2 => clk_saomiao ------------输出扫描频率500 hz
	);
			
	dis: xianshi PORT MAP (
			clk1    => clk_saomiao,
			num     => secnum, 
			light   => lightdata,
			ledcom  => seg7com,
			leddata => seg7data
			);
			
---------------------------------以下是按键消抖---------------------
--PROCESS(clk,key1) 
--BEGIN 
--IF(key1='0') THEN
--	IF(clk'event and clk='1') then
--		if(count1=250000) then
--			count1<=count1;
--		else
--			count1 <= count1+1;
--		end if;
--		
--		if(count1>250000-10) then 
--			flag <= '0';
--		else
--			flag <= '1';
--		end if;
--
--  end if;
--else
--	count1 <= 0;		
--END IF;
--END PROCESS;
--
--PROCESS(clk)
--BEGIN
--	if(clk'event and clk='1')then
--		if(flag='0')then
--			key_out<='0';
--		end if;
--		
--		if(sec_r=0)then
--			key_out<='1';
--		end if;
--	end if;
--END PROCESS;

process(clk)
begin
if(key1='0')then
	key_out<='0';
elsif(sec_r=0)then
	key_out<='1';
end if;

end process;
--------------------------------------------------以下是计数单元-----------------------

process(clk_jishu,key_out,lightstate)
	VARIABLE sec  :INTEGER RANGE 30 DOWNTO 0;
	VARIABLE light1:INTEGER RANGE 50 DOWNTO 0:=14;
	BEGIN
		if(clk_jishu'event and clk_jishu='1') then
			if(key_out='1')then
				light1:=14;
				sec:=29;
			elsif(lightstate=0)then               -------------车绿人红-----------
				light1 :=14;
				sec := sec_g;
				if(sec_g=0)then
					sec_g<=29;
				else
					sec_g<=sec_g-1;
				end if;
				
			elsif(lightstate=1)then            -------------车红人绿-----------
				light1 :=41;
				sec := sec_r;
				if(sec_r=0)then
					sec_r<=14;
				else
					sec_r<=sec_r-1;
				end if;
				
			elsif(lightstate=2)then              -------------车黄人红-----------
				light1 :=24;
				sec := sec_y;
				if(sec_y=0)then
					sec_y<=2;
				else
					sec_y<=sec_y-1;
				end if;
			end if;
			
		lightdata <= light1;
		secnum   <= sec;
		
		end if;
		

	END PROCESS;


------------------------------------------------------以下是状态机------------------------
PROCESS(pre_state,key_out,secnum)

BEGIN	
	case pre_state is
		when 0=> lightstate <=0;--------------车绿人红-----------
			if(key_out='0' and secnum=0)then
				next_state<=2;
			else
				next_state<=0;
			end if;
		
		when 1=> lightstate<=1;-------------车红人绿--------------
			if(secnum=0)then
				next_state<=0;
			else
				next_state<=1;
			end if;
			
		when 2=> lightstate<=2;-------------车黄人红-------------
			if(secnum=0)then
				next_state<=1;
			else
				next_state<=2;
			end if;
	end case;
END PROCESS;

PROCESS(clk)
BEGIN
	if(clk'event and clk='1')then
		pre_state<=next_state;
	end if;
END PROCESS;
END example;