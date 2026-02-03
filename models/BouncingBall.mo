model BouncingBall "Ball bouncing on the ground"
  parameter Real e = 0.8 "Coefficient of restitution";
  parameter Real g = 9.81 "Gravitational acceleration [m/s2]";
  Real h(start = 1.0) "Height [m]";
  Real v(start = 0.0) "Velocity [m/s]";
equation
  der(h) = v;
  der(v) = -g;
  when h <= 0 then
    reinit(v, -e * pre(v));
  end when;
end BouncingBall;
