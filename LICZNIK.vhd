
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;

entity LICZNIK is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
	------------OD LCD-----------------
    lcd_e  : out std_logic;
    lcd_rs : out std_logic;
    lcd_rw : out std_logic;
    lcd_db : out std_logic_vector(7 downto 4);
	 ---------------------------------------
			  p1: in STD_LOGIC;    --przycis ustawiaj¹cy godzine
			  p2: in STD_LOGIC;	  -- przycisk ustawiaj¹cy minuty
			  p_START: in STD_LOGIC); --prze³¹cznik startujacy zegar
end LICZNIK;

architecture A_LICZNIK of LICZNIK is

------------------------SYGNA£Y---------------------------------------------
type STANY is (START, USTAW_ZEGAR, CZAS_START); --, USTAW_GODZINE
signal STAN, STAN_NAST : STANY;

signal generator :std_logic_vector (25 downto 0); --(25 do 0)
signal Lsekund :std_logic_vector (7 downto 0);
signal Lminut :std_logic_vector (7 downto 0);
signal Lgodzin :std_logic_vector (7 downto 0);
signal bufer_h : std_logic_vector(7 downto 0);
signal bufer_min : std_logic_vector(7 downto 0);
signal bufer_sec : std_logic_vector(7 downto 0);

---preskalery---
signal clk_div1:  std_logic_vector (22 downto 0);
signal clk_div2:  std_logic_vector (21 downto 0);

----------------------------------------------------------------------------
begin
----------------KOMPONENT LCD-----------------------
blok_wys : entity work.LCD_wyswietlacz
	port map (clk=>clk,
				 bufer_h=>bufer_h,
				 bufer_min=>bufer_min,
				 bufer_sec=>bufer_sec,
				 rkt=>reset,
             lcd_e=>lcd_e,
				 lcd_rs=>lcd_rs,
				 lcd_rw=>lcd_rw,
				 lcd_db=>lcd_db);
-------------------------------------

--------------------------------------------MASZYNA STANÓW----------------------------------
reg:process(clk,reset)

begin
		if (reset='1')then
			STAN<=START;

		elsif(clk'Event and clk='1') then
			STAN<=STAN_NAST;
			clk_div1 <= clk_div1 + '1'; 
			clk_div2 <= clk_div2 + '1';
		end if; 
end process reg;


automat : process( reset, clk, STAN, p_START, Lsekund, Lgodzin, Lminut)
begin
		STAN_NAST <= STAN;
		case STAN is 
			when START => 
					STAN_NAST <= USTAW_ZEGAR;
					bufer_h<="00000000";
					bufer_min<="00000000";
					bufer_sec<="00000000";
					
				if (p_START='1') then
					STAN_NAST <= CZAS_START;				
				end if;

			when USTAW_ZEGAR =>
	
					bufer_h<=Lgodzin;
					bufer_min<=Lminut;
					bufer_sec<=Lsekund;
				if (p_START='1') then
					STAN_NAST <= CZAS_START;				
				end if;
			when CZAS_START =>
					bufer_h<=Lgodzin;
					bufer_min<=Lminut;
					bufer_sec<=Lsekund;
				if (p_START='1') then
					STAN_NAST <= CZAS_START;				
				else 
					STAN_NAST <= START;
				end if;
			end case;
end process automat;



licznik : process (clk, reset, STAN, p1,p2, p_START, clk_div1, clk_div2)
begin
	if(reset = '1') then 
		generator<=(others=>'0');
		Lsekund<=(others=>'0');
		Lminut<=(others=>'0');
		Lgodzin<=(others=>'0');
--		clk_div1<=(others=>'0');
--		clk_div2<=(others=>'0');
		
	elsif (clk'Event and clk = '1') then
		if (p1='1' and STAN=USTAW_ZEGAR and clk_div1 = "00000000000000000010011") then  --ustawianie przyciskeim p1 aktualnej godziny --and clk_div1 = 
			Lgodzin <= Lgodzin + 1;						     
						if (Lgodzin ="00010111") then
							Lgodzin<=(others=>'0');
						end if;
		end if;
		if (p2 ='1' and STAN=USTAW_ZEGAR and clk_div2 = "000000000000000001001") then	-- ustawianie przyciskiem p2 aktualnej minuty --and clk_div2 = 
						Lminut <= Lminut + 1;						
						if (Lminut = "0111011") then
								Lminut<=(others=>'0');
						end if;
		end if;
		----praca zegara--- autozliczanie---zaczyna sie w stanie CZAS_START
	   if (STAN=CZAS_START and generator = "10111110101111000010000000" ) then  --generator = "10111110101111000010000000"
			generator<=(others=>'0');
			Lsekund <= Lsekund + 1;
				if (Lsekund ="00111011" and STAN=CZAS_START)then
					Lsekund<=(others=>'0');
					Lminut<=Lminut+1;
						if(Lminut="00111011" and STAN=CZAS_START) then
							Lminut<=(others=>'0');
							Lgodzin <= Lgodzin+1;
								if (Lgodzin= "00011000" and STAN=CZAS_START) then
									Lgodzin<=(others=>'0');
								end if;
						end if;
										end if;
		  end if;
		generator <= generator +1;
	end if;
end process licznik;

	
end A_LICZNIK;





-----------------
--elsif (clk'Event and clk = '1') then
--			clk_div1 <= clk_div1 + '1'; 
--			clk_div2 <= clk_div2 + '1';
--			if (p1= '1' and STAN=USTAW_ZEGAR and clk_div1 = "100110001001011010000000" ) then	-- przycisk 1 ( regulacja minut )
--						bufor_min <= bufor_min + 1;
--						if (bufor_min ="00111011") then
--							bufor_min<=(others=>'0');
--						end if;
--			end if;
--			if (p2= '1' and STAN=USTAW_ZEGAR and clk_div2 = "1111111111111111111111111") then	-- przycisk 2 ( reguacja godzin )
--						bufor_h <= bufor_h + 1;						
--						if (bufor_h = "00010111") then
--								bufor_h<=(others=>'0');
--						end if;
--			end if;
