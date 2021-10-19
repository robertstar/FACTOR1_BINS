----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2019 08:32:39
-- Design Name: 
-- Module Name: cordic_sin_cos - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cordic_sin_cos is
    Port ( clk        : in  STD_LOGIC;
           angle      : in  STD_LOGIC_VECTOR (23 downto 0);
           signed_sin : out STD_LOGIC_VECTOR (23 downto 0) := (others => '0');
           signed_cos : out STD_LOGIC_VECTOR (23 downto 0) := (others => '0'));
end cordic_sin_cos;

architecture Behavioral of cordic_sin_cos is
    constant stages    : natural := 26;
    constant calc_bits : natural := 28;
    constant z_bits    : natural := 29;

    -- Angles for the CORDIC algorithm in fixed decimal (eg. 0x4b90147 ~= atan(0.5))
    type a_angles is array(0 to stages) of signed(z_bits-2 downto 0);
    constant angles : a_angles := (
            x"4b90147", x"27ece16", x"1444475", x"0a2c350", x"05175f8", x"028bd87",
            x"0145f15", x"00a2f94", x"00517cb", x"0028be6", x"00145f3", x"000a2f9",
            x"000517c", x"00028be", x"000145f", x"0000a2f", x"0000517", x"000028b",
            x"0000145", x"00000a2", x"0000051", x"0000028", x"0000014", x"000000a",
            x"0000005", x"0000002", x"0000001");

    -- Adjusted to give full scale of +0x7FFFF & -0x7FFFF
    constant initial      : signed(calc_bits-1 downto 0) := x"4dba76c";
    
    -- Constants for quadrant calulations
    constant quarter_turn : signed(z_bits-1 downto 0)    := "10000" & x"000000";
    constant eigth_turn   : signed(z_bits-1 downto 0)    := "01000" & x"000000";
    constant zero         : signed(signed_sin'high downto 0) := (others => '0');
    signal quadrant_angle : signed(z_bits-1 downto 0)    := (others => '0');

    -- Pipeline for holding the quadrant information
    signal flip_cos : std_logic_vector(stages+1 downto 0);
    signal flip_sin : std_logic_vector(stages+1 downto 0);
    
    -- Pipeline for CORDIC X, Y & Z state variables positions
    type a_x_or_y is array(0 to stages+1) of signed(calc_bits-1 downto 0);
    type a_z      is array(0 to stages+1) of signed(z_bits-1 downto 0);
    signal x       : a_x_or_y := (0 => initial, others => (others => '0'));
    signal y       : a_x_or_y := (0 => initial, others => (others => '0'));
    signal z       : a_z      := (others => (others => '0'));

begin

    quadrant_angle(quadrant_angle'high-1 downto quadrant_angle'high-angle'high+1)  <= signed(angle(angle'high-2 downto 0));

process(clk)
    begin
        if rising_edge(clk) then
            -- The Output stages
            if flip_sin(stages+1) = '0' then
                signed_sin <= STD_LOGIC_VECTOR (zero + y(stages+1)(calc_bits-1 downto calc_bits-signed_sin'length));
            else
                signed_sin <= STD_LOGIC_VECTOR (zero - y(stages+1)(calc_bits-1 downto calc_bits-signed_sin'length));
            end if;

            if flip_cos(stages+1) = '0' then
                signed_cos <= STD_LOGIC_VECTOR (zero + x(stages+1)(calc_bits-1 downto calc_bits-signed_cos'length));
            else
                signed_cos <= STD_LOGIC_VECTOR (zero - x(stages+1)(calc_bits-1 downto calc_bits-signed_cos'length));
            end if;
            
            -- The actual CORDIC stages
            for i in 0 to stages loop
                if z(i)(z_bits-1) = '0' then
                    x(i+1) <= x(i) - resize(y(i)(calc_bits-1 downto i+1),calc_bits);
                    y(i+1) <= y(i) + resize(x(i)(calc_bits-1 downto i+1),calc_bits);
                    z(i+1) <= z(i) - angles(i);
                else
                    x(i+1) <= x(i) + resize(y(i)(calc_bits-1 downto i+1),calc_bits);
                    y(i+1) <= y(i) - resize(x(i)(calc_bits-1 downto i+1),calc_bits);
                    z(i+1) <= z(i) + angles(i);
                end if;
                flip_sin(i+1) <= flip_sin(i);
                flip_cos(i+1) <= flip_cos(i);
            end loop;

            -- Setup for the CORDIC algorithm, which only works on the first quadrant of a circle
            case angle(angle'high downto angle'high-1) is
                when "00" =>
                    flip_sin(0) <= '0';
                    flip_cos(0) <= '0';
                    z(0) <=                quadrant_angle - eigth_turn;
                when "01" =>  
                    flip_sin(0) <= '0';
                    flip_cos(0) <= '1';
                    z(0) <= quarter_turn - quadrant_angle - eigth_turn;
                when "10" =>
                    flip_sin(0) <= '1';
                    flip_cos(0) <= '1';
                    z(0) <=                quadrant_angle - eigth_turn;
                when others =>
                    flip_sin(0) <= '1';
                    flip_cos(0) <= '0';
                    z(0) <= quarter_turn - quadrant_angle - eigth_turn;
            end case;
        end if;
    end process;
end Behavioral;
