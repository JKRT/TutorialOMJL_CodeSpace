model Pendulum "Constrained pendulum"
  parameter Real L = 1.0 "Pendulum length [m]";
  parameter Real g = 9.81 "Gravitational acceleration [m/s2]";
  Real theta(start = 0.5) "Angle from vertical [rad]";
  Real omega(start = 0.0) "Angular velocity [rad/s]";
  Real x "Horizontal position [m]";
  Real y "Vertical position [m]";
equation
  der(theta) = omega;
  der(omega) = -g/L * sin(theta);
  x = L * sin(theta);
  y = -L * cos(theta);
end Pendulum;
