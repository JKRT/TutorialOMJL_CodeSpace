model SimpleCircuit "RLC circuit with sinusoidal source"
  Real i(start = 0) "Current [A]";
  Real u_R "Resistor voltage [V]";
  Real u_L "Inductor voltage [V]";
  Real u_C(start = 0) "Capacitor voltage [V]";
  parameter Real R = 10 "Resistance [Ohm]";
  parameter Real L = 0.1 "Inductance [H]";
  parameter Real C = 0.01 "Capacitance [F]";
  parameter Real V = 5 "Source amplitude [V]";
  parameter Real freq = 10 "Frequency [Hz]";
equation
  u_R = R * i;
  u_L = L * der(i);
  der(u_C) = i / C;
  V * sin(2 * 3.14159 * freq * time) = u_R + u_L + u_C;
end SimpleCircuit;
