model VanDerPol "Van der Pol oscillator"
  Real x(start = 1.0) "Position";
  Real y(start = 1.0) "Velocity";
  parameter Real lambda = 0.3 "Damping parameter";
equation
  der(x) = y;
  der(y) = -x + lambda * (1 - x^2) * y;
end VanDerPol;
