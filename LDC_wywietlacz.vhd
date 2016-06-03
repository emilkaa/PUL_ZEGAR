
library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity LCD_wyswietlacz is
  port (
    clk    : in  std_logic;
	 rkt	: in std_logic;
    lcd_e  : out std_logic;
    lcd_rs : out std_logic;
    lcd_rw : out std_logic;
    lcd_db : out std_logic_vector(7 downto 4);
	 bufer_h : in std_logic_vector(7 downto 0);
	 bufer_min : in std_logic_vector(7 downto 0);
    bufer_sec : in std_logic_vector(7 downto 0));
	
end entity LCD_wyswietlacz;

-------------------------------------------------------------------------------

architecture A_LCD_wyswietlacz of LCD_wyswietlacz is

  -- 
  signal timer : natural range 0 to 100000000 := 0;
  signal switch_lines : std_logic := '0';
  signal line1 : std_logic_vector(127 downto 0);
  signal line2 : std_logic_vector(127 downto 0);
  

  -- component generics
  constant CLK_PERIOD_NS : positive := 20;  -- 50 Mhz

  -- component ports
  signal reset          : std_logic;
  signal line1_buffer : std_logic_vector(127 downto 0);
  signal line2_buffer : std_logic_vector(127 downto 0);

begin  -- architecture behavior

  -- component instantiation
  DUT : entity work.LDC_implementacja
    generic map (
      CLK_PERIOD_NS => CLK_PERIOD_NS)
    port map (
      clk          => clk,
      reset         => reset,
      lcd_e        => lcd_e,
      lcd_rs       => lcd_rs,
      lcd_rw       => lcd_rw,
      lcd_db       => lcd_db,
      line1_buffer => line1_buffer,
      line2_buffer => line2_buffer);

  reset <= '0';

  -- see the display's datasheet for the character map
  line1(127 downto 120) <= X"20"; 
  line1(119 downto 112) <= X"20";
  line1(111 downto 104) <= x"30" when bufer_h="00000000" else--00
									x"30" when bufer_h="00000001" else--01
									x"30" when bufer_h="00000010" else--02
									x"30" when bufer_h="00000011" else--03
									x"30" when bufer_h="00000100" else--04
									x"30" when bufer_h="00000101" else--05
									x"30" when bufer_h="00000110" else--06
									x"30" when bufer_h="00000111" else--07
									x"30" when bufer_h="00001000" else--08
									x"30" when bufer_h="00001001" else--09
									
									x"31" when bufer_h="00001010" else--10
									x"31" when bufer_h="00001011" else--11
									x"31" when bufer_h="00001100" else--12
									x"31" when bufer_h="00001101" else--13
									x"31" when bufer_h="00001110" else--14
									x"31" when bufer_h="00001111" else--15
									x"31" when bufer_h="00010000" else--16
									x"31" when bufer_h="00010001" else--17
									x"31" when bufer_h="00010010" else--18
									x"31" when bufer_h="00010011" else--19
									
									x"32" when bufer_h="00010100" else--20
									x"32" when bufer_h="00010101" else--21
									x"32" when bufer_h="00010110" else--22
									x"32" when bufer_h="00010111";    --23
									
  line1(103 downto 96)  <=-- x"30" when bufer_h="00000000" else
									x"31" when bufer_h="00000001" else
									x"32" when bufer_h="00000010" else
									x"33" when bufer_h="00000011" else
									x"34" when bufer_h="00000100" else
									x"35" when bufer_h="00000101" else
									x"36" when bufer_h="00000110" else
									x"37" when bufer_h="00000111" else
									x"38" when bufer_h="00001000" else
									x"39" when bufer_h="00001001" else
									
									x"30" when bufer_h="00001010" else
									x"31" when bufer_h="00001011" else
									x"32" when bufer_h="00001100" else
									x"33" when bufer_h="00001101" else
									x"34" when bufer_h="00001110" else
									x"35" when bufer_h="00001111" else
									x"36" when bufer_h="00010000" else
									x"37" when bufer_h="00010001" else
									x"38" when bufer_h="00010010" else
									x"39" when bufer_h="00010011" else
									
									x"30" when bufer_h="00010100" else
									x"31" when bufer_h="00010101" else
									x"32" when bufer_h="00010110" else
									x"33" when bufer_h="00010111";
									
  line1(95 downto 88)   <= x"3a";  -- :
  
  line1(87 downto 80)   <= x"30" when bufer_min="00000000" else--00
									x"30" when bufer_min="00000001" else
									x"30" when bufer_min="00000010" else
									x"30" when bufer_min="00000011" else
									x"30" when bufer_min="00000100" else
									x"30" when bufer_min="00000101" else
									x"30" when bufer_min="00000110" else
									x"30" when bufer_min="00000111" else
									x"30" when bufer_min="00001000" else
									x"30" when bufer_min="00001001" else
									--10----------------19----------
									x"31" when bufer_min="00001010" else
									x"31" when bufer_min="00001011" else
									x"31" when bufer_min="00001100" else
									x"31" when bufer_min="00001101" else
									x"31" when bufer_min="00001110" else
									x"31" when bufer_min="00001111" else
									x"31" when bufer_min="00010000" else
									x"31" when bufer_min="00010001" else
									x"31" when bufer_min="00010010" else
									x"31" when bufer_min="00010011" else
									-----20----------29-------------
									x"32" when bufer_min="00010100" else
									x"32" when bufer_min="00010101" else
									x"32" when bufer_min="00010110" else
									x"32" when bufer_min="00010111" else
									x"32" when bufer_min="00011000" else
									x"32" when bufer_min="00011001" else
									x"32" when bufer_min="00011010" else
									x"32" when bufer_min="00011011" else
									x"32" when bufer_min="00011100" else
									x"32" when bufer_min="00011101" else
									------30----------39--------
									x"33" when bufer_min="00011110" else
									x"33" when bufer_min="00011111" else
									x"33" when bufer_min="00100000" else
									x"33" when bufer_min="00100001" else
									x"33" when bufer_min="00100010" else
									x"33" when bufer_min="00100011" else
									x"33" when bufer_min="00100100" else
									x"33" when bufer_min="00100101" else
									x"33" when bufer_min="00100110" else
									x"33" when bufer_min="00100111" else
									--------40-------49----0------
									x"34" when bufer_min="00101000" else
									x"34" when bufer_min="00101001" else
									x"34" when bufer_min="00101010" else
									x"34" when bufer_min="00101011" else
									x"34" when bufer_min="00101100" else
									x"34" when bufer_min="00101101" else
									x"34" when bufer_min="00101110" else
									x"34" when bufer_min="00101111" else
									x"34" when bufer_min="00110000" else
									x"34" when bufer_min="00110001" else

										-----50-------59---------
									x"35" when bufer_min="00110010" else
									x"35" when bufer_min="00110011" else
									x"35" when bufer_min="00110100" else
									x"35" when bufer_min="00110101" else
									x"35" when bufer_min="00110110" else
									x"35" when bufer_min="00110111" else
									x"35" when bufer_min="00111000" else
									x"35" when bufer_min="00111001" else
									x"35" when bufer_min="00111010" else
									x"35"; 
									
									
  line1(79 downto 72)   <= x"30" when bufer_min="00000000" else--00
									x"31" when bufer_min="00000001" else
									x"32" when bufer_min="00000010" else
									x"33" when bufer_min="00000011" else
									x"34" when bufer_min="00000100" else
									x"35" when bufer_min="00000101" else
									x"36" when bufer_min="00000110" else
									x"37" when bufer_min="00000111" else
									x"38" when bufer_min="00001000" else
									x"39" when bufer_min="00001001" else
									--10----------------19----------
									x"30" when bufer_min="00001010" else
									x"31" when bufer_min="00001011" else
									x"32" when bufer_min="00001100" else
									x"33" when bufer_min="00001101" else
									x"34" when bufer_min="00001110" else
									x"35" when bufer_min="00001111" else
									x"36" when bufer_min="00010000" else
									x"37" when bufer_min="00010001" else
									x"38" when bufer_min="00010010" else
									x"39" when bufer_min="00010011" else
									----20----------29-----0--------
									x"30" when bufer_min="00010100" else
									x"31" when bufer_min="00010101" else
									x"32" when bufer_min="00010110" else
									x"33" when bufer_min="00010111" else
									x"34" when bufer_min="00011000" else
									x"35" when bufer_min="00011001" else
									x"36" when bufer_min="00011010" else
									x"37" when bufer_min="00011011" else
									x"38" when bufer_min="00011100" else
									x"39" when bufer_min="00011101" else
									-----30----------39--------
									x"30" when bufer_min="00011110" else
									x"31" when bufer_min="00011111" else
									x"32" when bufer_min="00100000" else
									x"33" when bufer_min="00100001" else
									x"34" when bufer_min="00100010" else
									x"35" when bufer_min="00100011" else
									x"36" when bufer_min="00100100" else
									x"37" when bufer_min="00100101" else
									x"38" when bufer_min="00100110" else
									x"39" when bufer_min="00100111" else
									--------40-------49----------
									x"30" when bufer_min="00101000" else
									x"31" when bufer_min="00101001" else
									x"32" when bufer_min="00101010" else
									x"33" when bufer_min="00101011" else
									x"34" when bufer_min="00101100" else
									x"35" when bufer_min="00101101" else
									x"36" when bufer_min="00101110" else
									x"37" when bufer_min="00101111" else
									x"38" when bufer_min="00110000" else
									x"39" when bufer_min="00110001" else

										-----50-------59---------
									x"30" when bufer_min="00110010" else
									x"31" when bufer_min="00110011" else
									x"32" when bufer_min="00110100" else
									x"33" when bufer_min="00110101" else
									x"34" when bufer_min="00110110" else
									x"35" when bufer_min="00110111" else
									x"36" when bufer_min="00111000" else
									x"37" when bufer_min="00111001" else
									x"38" when bufer_min="00111010" else
									x"39"; 
									
  line1(71 downto 64)   <= X"3a";  -- :
  
  line1(63 downto 56)   <= x"30" when bufer_sec="00000000" else--00
									x"30" when bufer_sec="00000001" else
									x"30" when bufer_sec="00000010" else
									x"30" when bufer_sec="00000011" else
									x"30" when bufer_sec="00000100" else
									x"30" when bufer_sec="00000101" else
									x"30" when bufer_sec="00000110" else
									x"30" when bufer_sec="00000111" else
									x"30" when bufer_sec="00001000" else
									x"30" when bufer_sec="00001001" else
									--10----------------19----------
									x"31" when bufer_sec="00001010" else
									x"31" when bufer_sec="00001011" else
									x"31" when bufer_sec="00001100" else
									x"31" when bufer_sec="00001101" else
									x"31" when bufer_sec="00001110" else
									x"31" when bufer_sec="00001111" else
									x"31" when bufer_sec="00010000" else
									x"31" when bufer_sec="00010001" else
									x"31" when bufer_sec="00010010" else
									x"31" when bufer_sec="00010011" else
									-----20----------29-------------
									x"32" when bufer_sec="00010100" else
									x"32" when bufer_sec="00010101" else
									x"32" when bufer_sec="00010110" else
									x"32" when bufer_sec="00010111" else
									x"32" when bufer_sec="00011000" else
									x"32" when bufer_sec="00011001" else
									x"32" when bufer_sec="00011010" else
									x"32" when bufer_sec="00011011" else
									x"32" when bufer_sec="00011100" else
									x"32" when bufer_sec="00011101" else
									------30----------39--------
									x"33" when bufer_sec="00011110" else
									x"33" when bufer_sec="00011111" else
									x"33" when bufer_sec="00100000" else
									x"33" when bufer_sec="00100001" else
									x"33" when bufer_sec="00100010" else
									x"33" when bufer_sec="00100011" else
									x"33" when bufer_sec="00100100" else
									x"33" when bufer_sec="00100101" else
									x"33" when bufer_sec="00100110" else
									x"33" when bufer_sec="00100111" else
									--------40-------49----0------
									x"34" when bufer_sec="00101000" else
									x"34" when bufer_sec="00101001" else
									x"34" when bufer_sec="00101010" else
									x"34" when bufer_sec="00101011" else
									x"34" when bufer_sec="00101100" else
									x"34" when bufer_sec="00101101" else
									x"34" when bufer_sec="00101110" else
									x"34" when bufer_sec="00101111" else
									x"34" when bufer_sec="00110000" else
									x"34" when bufer_sec="00110001" else

										-----50-------59---------
									x"35" when bufer_sec="00110010" else
									x"35" when bufer_sec="00110011" else
									x"35" when bufer_sec="00110100" else
									x"35" when bufer_sec="00110101" else
									x"35" when bufer_sec="00110110" else
									x"35" when bufer_sec="00110111" else
									x"35" when bufer_sec="00111000" else
									x"35" when bufer_sec="00111001" else
									x"35" when bufer_sec="00111010" else
									x"35"; 

  line1(55 downto 48)   <= x"30" when bufer_sec="00000000" else--00
									x"31" when bufer_sec="00000001" else
									x"32" when bufer_sec="00000010" else
									x"33" when bufer_sec="00000011" else
									x"34" when bufer_sec="00000100" else
									x"35" when bufer_sec="00000101" else
									x"36" when bufer_sec="00000110" else
									x"37" when bufer_sec="00000111" else
									x"38" when bufer_sec="00001000" else
									x"39" when bufer_sec="00001001" else
									--10----------------19----------
									x"30" when bufer_sec="00001010" else
									x"31" when bufer_sec="00001011" else
									x"32" when bufer_sec="00001100" else
									x"33" when bufer_sec="00001101" else
									x"34" when bufer_sec="00001110" else
									x"35" when bufer_sec="00001111" else
									x"36" when bufer_sec="00010000" else
									x"37" when bufer_sec="00010001" else
									x"38" when bufer_sec="00010010" else
									x"39" when bufer_sec="00010011" else
									----20----------29-------------
									x"30" when bufer_sec="00010100" else
									x"31" when bufer_sec="00010101" else
									x"32" when bufer_sec="00010110" else
									x"33" when bufer_sec="00010111" else
									x"34" when bufer_sec="00011000" else
									x"35" when bufer_sec="00011001" else
									x"36" when bufer_sec="00011010" else
									x"37" when bufer_sec="00011011" else
									x"38" when bufer_sec="00011100" else
									x"39" when bufer_sec="00011101" else
									-----30----------39--------
									x"30" when bufer_sec="00011110" else
									x"31" when bufer_sec="00011111" else
									x"32" when bufer_sec="00100000" else
									x"33" when bufer_sec="00100001" else
									x"34" when bufer_sec="00100010" else
									x"35" when bufer_sec="00100011" else
									x"36" when bufer_sec="00100100" else
									x"37" when bufer_sec="00100101" else
									x"38" when bufer_sec="00100110" else
									x"39" when bufer_sec="00100111" else
									--------40-------49----------
									x"30" when bufer_sec="00101000" else
									x"31" when bufer_sec="00101001" else
									x"32" when bufer_sec="00101010" else
									x"33" when bufer_sec="00101011" else
									x"34" when bufer_sec="00101100" else
									x"35" when bufer_sec="00101101" else
									x"36" when bufer_sec="00101110" else
									x"37" when bufer_sec="00101111" else
									x"38" when bufer_sec="00110000" else
									x"39" when bufer_sec="00110001" else

										-----50-------59---------
									x"30" when bufer_sec="00110010" else
									x"31" when bufer_sec="00110011" else
									x"32" when bufer_sec="00110100" else
									x"33" when bufer_sec="00110101" else
									x"34" when bufer_sec="00110110" else
									x"35" when bufer_sec="00110111" else
									x"36" when bufer_sec="00111000" else
									x"37" when bufer_sec="00111001" else
									x"38" when bufer_sec="00111010" else
									x"31" when bufer_sec="00000001" else
									x"32" when bufer_sec="00000010" else
									x"33" when bufer_sec="00000011" else
									x"34" when bufer_sec="00000100" else
									x"35" when bufer_sec="00000101" else
									x"36" when bufer_sec="00000110" else
									x"37" when bufer_sec="00000111" else
									x"38" when bufer_sec="00001000" else
									x"39";
									
									
  line1(47 downto 40)   <= X"20";  --
  line1(39 downto 32)   <= x"20";  -- 
  line1(31 downto 24)   <= x"20";  -- 
  line1(23 downto 16)   <= x"20";  -- 
  line1(15 downto 8)    <= X"20";
  line1(7 downto 0)     <= X"20";

  line2(127 downto 120) <= X"20";  -- 
  line2(119 downto 112) <= X"20";  --
  line2(111 downto 104) <= X"20";  --
  line2(103 downto 96)  <= X"20";  -- 
  line2(95 downto 88)   <= X"20";  --
  line2(87 downto 80)   <= X"20";  -- 
  line2(79 downto 72)   <= X"20";  -- 
  line2(71 downto 64)   <= X"20";  -- 
  line2(63 downto 56)   <= X"20";  -- 
  line2(55 downto 48)   <= X"20";  -- 
  line2(47 downto 40)   <= X"20";  -- 
  line2(39 downto 32)   <= X"20";  -- 
  line2(31 downto 24)   <= X"20";  -- 
  line2(23 downto 16)   <= X"20";  --
  line2(15 downto 8)    <= X"20";  -- 
  line2(7 downto 0)     <= X"20";  -- 

  line1_buffer <= line1;-- when switch_lines = '1' else line1;
  line2_buffer <= line2;-- when switch_lines = '1' else line2;

  -- switch lines every second
  process(clk)
  begin
    if rising_edge(clk) then
      if timer = 0 then
        timer <= 100000000;
        switch_lines <= not switch_lines;
      else
        timer <= timer - 1;
      end if;
    end if;
      
  end process;
end architecture A_LCD_wyswietlacz;

