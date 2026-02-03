/*
  Simple RLC Circuit using Modelica Standard Library Components

  Demonstrates:
  - Importing MSL components
  - Using connect() for acausal connections
  - Component-based modeling
*/

model SimpleCircuitMSL
  // MSL Imports
  import Modelica.Electrical.Analog.Basic.Ground;
  import Modelica.Electrical.Analog.Basic.Resistor;
  import Modelica.Electrical.Analog.Basic.Capacitor;
  import Modelica.Electrical.Analog.Basic.Inductor;
  import Modelica.Electrical.Analog.Sources.SineVoltage;

  // Components
  Resistor R1(R = 10) "Resistor in capacitor branch";
  Capacitor C(C = 0.01) "Capacitor";
  Resistor R2(R = 100) "Resistor in inductor branch";
  Inductor L(L = 0.1) "Inductor";
  SineVoltage AC(freqHz = 1.0, phase = 1.0) "AC voltage source";
  Ground G "Ground reference";

equation
  // Capacitor branch
  connect(AC.p, R1.p);
  connect(R1.n, C.p);
  connect(C.n, AC.n);

  // Inductor branch (parallel)
  connect(R1.p, R2.p);
  connect(R2.n, L.p);
  connect(L.n, C.n);

  // Ground connection
  connect(AC.n, G.p);

end SimpleCircuitMSL;
