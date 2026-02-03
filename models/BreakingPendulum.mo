/*
  Breaking Pendulum Example for OMJL Tutorial

  Demonstrates variable-structure systems with:
  - Static structural transitions (structuralmode)
  - Dynamic recompilation
*/

package BreakingPendulum

model FreeFall "Unconstrained free fall in 2D"
  parameter Real g = 9.81 "Gravitational acceleration [m/s2]";
  Real x(start = 0.0) "Horizontal position [m]";
  Real y(start = 0.0) "Vertical position [m]";
  Real vx(start = 0.0) "Horizontal velocity [m/s]";
  Real vy(start = 0.0) "Vertical velocity [m/s]";
equation
  der(x) = vx;
  der(y) = vy;
  der(vy) = -g;
  der(vx) = 0.0;
end FreeFall;

model Pendulum "Constrained pendulum"
  parameter Real x0 = 10 "Initial horizontal position";
  parameter Real y0 = 10 "Initial vertical position";
  parameter Real g = 9.81 "Gravitational acceleration";
  parameter Real L = sqrt(x0^2 + y0^2) "Pendulum length";
  Real x(start = x0) "Horizontal position";
  Real y(start = y0) "Vertical position";
  Real vx "Horizontal velocity";
  Real vy "Vertical velocity";
  Real phi "Angle";
  Real phid "Angular velocity";
equation
  x = L * sin(phi);
  y = -L * cos(phi);
  der(x) = vx;
  der(y) = vy;
  der(phi) = phid;
  der(phid) = -g / L * sin(phi);
end Pendulum;

model BouncingBall "Free fall with ground bounce"
  parameter Real e = 0.7 "Coefficient of restitution";
  parameter Real g = 9.81 "Gravitational acceleration";
  Real x(start = 0.0) "Horizontal position";
  Real y(start = 1.0) "Vertical position";
  Real vx(start = 0.0) "Horizontal velocity";
  Real vy(start = 0.0) "Vertical velocity";
equation
  der(vy) = -g;
  der(vx) = 0.0;
  der(y) = vy;
  der(x) = vx;
  when y <= 0 then
    reinit(vy, -e*pre(vy));
  end when;
end BouncingBall;

model BreakingPendulumStatic "Static variable-structure: pendulum to free fall"
  structuralmode Pendulum pendulum;
  structuralmode FreeFall freeFall;
equation
  initialStructuralState(pendulum);
  structuralTransition(pendulum, freeFall, time <= 5);
end BreakingPendulumStatic;

model BreakingPendulumStaticBouncingBall "Static variable-structure: pendulum to bouncing ball"
  structuralmode Pendulum pendulum;
  structuralmode BouncingBall bouncingBall;
equation
  initialStructuralState(pendulum);
  structuralTransition(pendulum, bouncingBall, time <= 5);
end BreakingPendulumStaticBouncingBall;

model BreakingPendulumDynamic "Dynamic recompilation: pendulum to free fall"
  parameter Boolean breaks = false;
  FreeFall freeFall if breaks;
  Pendulum pendulum if not breaks;
equation
  when 5.0 <= time then
    recompilation(breaks, true);
  end when;
end BreakingPendulumDynamic;

end BreakingPendulum;
