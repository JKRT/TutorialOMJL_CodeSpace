model LotkaVolterra "Predator-prey dynamics"
  Real x(start = 10) "Prey population";
  Real y(start = 10) "Predator population";
  parameter Real alpha = 0.1 "Prey birth rate";
  parameter Real beta = 0.02 "Predation rate";
  parameter Real delta = 0.02 "Predator growth from predation";
  parameter Real gamma = 0.4 "Predator death rate";
equation
  der(x) = x * (alpha - beta * y);
  der(y) = y * (delta * x - gamma);
end LotkaVolterra;
