
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY TEST_LICZNIK IS
END TEST_LICZNIK;
 
ARCHITECTURE behavior OF TEST_LICZNIK IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LICZNIK
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
			  p1: in STD_LOGIC;
			  p2: in STD_LOGIC;
			  p_START: in STD_LOGIC;
         wy_sec : OUT  std_logic_vector(6 downto 0);
         wy_min : OUT  std_logic_vector(6 downto 0);
         wy_godz : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
	signal  p1:  STD_LOGIC := '0';
	signal  p2: STD_LOGIC := '0';
	signal  p_START:  STD_LOGIC := '0';

 	--Outputs
   signal wy_sec : std_logic_vector(6 downto 0);
   signal wy_min : std_logic_vector(6 downto 0);
   signal wy_godz : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LICZNIK PORT MAP (
          clk => clk,
          reset => reset,
			 p1=> p1,
			 p2=> p2,
			 p_START=> p_START,
          wy_sec => wy_sec,
          wy_min => wy_min,
          wy_godz => wy_godz
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset <= '1';
      wait for 10 ns;	
		reset <= '0';
      wait for clk_period;
		p1<='1';
		--p2<='1';
		wait for clk_period;
		p1<='0';
		wait for clk_period;
		p1<='1';
		wait for clk_period;
		p1<='0';
		wait for clk_period;
		p1<='1';
		wait for clk_period;
		p1<='0';
		wait for clk_period;
		p1<='1';
		wait for clk_period;
		p1<='0';
		wait for clk_period;
		p1<='1';
		wait for clk_period;
		p1<='0';
		wait for clk_period;
		p1<='1';
		wait for clk_period;
		p1<='0';
		wait for clk_period;
		p1<='1';
		wait for clk_period;
		p1<='0';
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
      wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';	
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
	   wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';		
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';		wait for clk_period;
		p2<='1';
		wait for clk_period;
		p2<='0';
      wait for clk_period;
		
		p_START<='1';
		wait for clk_period;
		
      wait for clk_period*10000;

      -- insert stimulus here 

      wait;
   end process;

END;
