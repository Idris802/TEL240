model AirHeater
  Modelica.Blocks.Math.Division division annotation(
    Placement(visible = true, transformation(origin = {82, -50}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add3(k3 = -1)  annotation(
    Placement(visible = true, transformation(origin = {7, -35}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant theta(k = 23.0)  "[s]" annotation(
    Placement(visible = true, transformation(origin = {6, -110}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  Modelica.Blocks.Math.Gain K_h(k = 3.5)  "[(deg C)/V]" annotation(
    Placement(visible = true, transformation(origin = {-81, 39}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.FixedDelay tau(delayTime = 3.0) "[s]" annotation(
    Placement(visible = true, transformation(origin = {-160, 40}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  Modelica.Blocks.Sources.Step r(height = 1, offset = 25, startTime = 150) "deg C" annotation(
    Placement(visible = true, transformation(origin = {-357, 11}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant T_env(k = 25.0) "[C]" annotation(
    Placement(visible = true, transformation(origin = {-160, -36}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  Modelica.Blocks.Continuous.PID pid(Nd = 10,Td = 0,Ti = 13.75, k = 0.9)  annotation(
    Placement(visible = true, transformation(origin = {-223, 11}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator annotation(
    Placement(visible = true, transformation(origin = {178, -50}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {-291, 11}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
equation
  connect(add3.y, division.u1) annotation(
    Line(points = {{30, -35}, {54, -35}, {54, -36}}, color = {0, 0, 127}));
  connect(theta.y, division.u2) annotation(
    Line(points = {{30, -110}, {30, -64}, {54, -64}}, color = {0, 0, 127}));
  connect(K_h.y, add3.u1) annotation(
    Line(points = {{-60, 39}, {-50, 39}, {-50, -18}, {-18, -18}}, color = {0, 0, 127}));
  connect(tau.y, K_h.u) annotation(
    Line(points = {{-140, 40}, {-140, 39}, {-104, 39}}, color = {0, 0, 127}));
  connect(T_env.y, add3.u2) annotation(
    Line(points = {{-136, -36}, {-18, -36}, {-18, -34}}, color = {0, 0, 127}));
  connect(pid.y, tau.u) annotation(
    Line(points = {{-202, 10}, {-194, 10}, {-194, 40}, {-182, 40}}, color = {0, 0, 127}));
  connect(division.y, integrator.u) annotation(
    Line(points = {{108, -50}, {152, -50}}, color = {0, 0, 127}));
  connect(integrator.y, add3.u3) annotation(
    Line(points = {{202, -50}, {220, -50}, {220, -162}, {-50, -162}, {-50, -52}, {-18, -52}}, color = {0, 0, 127}));
  connect(r.y, feedback.u1) annotation(
    Line(points = {{-336, 12}, {-308, 12}, {-308, 10}}, color = {0, 0, 127}));
  connect(integrator.y, feedback.u2) annotation(
    Line(points = {{202, -50}, {260, -50}, {260, -190}, {-290, -190}, {-290, -6}}, color = {0, 0, 127}));
  connect(feedback.y, pid.u) annotation(
    Line(points = {{-272, 10}, {-246, 10}, {-246, 12}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-400, -300}, {300, 200}})),
    Icon(coordinateSystem(extent = {{-400, -300}, {300, 200}})),
    version = "",
    uses(Modelica(version = "3.2.3")));
end AirHeater;