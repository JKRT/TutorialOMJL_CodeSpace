model FreeFall "Unconstrained free fall in 2D"
  parameter Real g = 9.81 "Gravitational acceleration [m/s2]";
  Real x(start = 0) "Horizontal position [m]";
  Real y(start = -1) "Vertical position [m]";
  Real vx(start = 0) "Horizontal velocity [m/s]";
  Real vy(start = 0) "Vertical velocity [m/s]";
equation
  der(x) = vx;
  der(y) = vy;
  der(vx) = 0;
  der(vy) = -g;
end FreeFall;
