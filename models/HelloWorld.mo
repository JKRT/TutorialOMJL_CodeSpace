model HelloWorld "Simple exponential decay"
  Real x(start = 1.0) "State variable";
  parameter Real a = 1.0 "Decay rate";
equation
  der(x) = -a * x;
end HelloWorld;
