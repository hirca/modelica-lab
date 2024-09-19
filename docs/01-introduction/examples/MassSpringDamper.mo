model MassSpringDamper "Quarter-car suspension model"
  import Modelica.Mechanics.Translational.Components;
  import Modelica.Blocks.Sources.Sine;
  import Modelica.Mechanics.Translational.Sources.Position;
  import Modelica.Units.SI;

  // Parameters
  parameter SI.Mass m = 1000 "Mass of the vehicle body [kg]";
  parameter SI.TranslationalSpringConstant k = 50000 "Suspension spring stiffness [N/m]";
  parameter SI.TranslationalDampingConstant c = 4000 "Suspension damping coefficient [N.s/m]";
  
  parameter SI.Length amplitude = 0.05 "Amplitude of road disturbance [m]";
  parameter SI.Frequency f = 1 "Frequency of road disturbance [Hz]";
  parameter SI.Angle phase = 0 "Phase of road disturbance [rad]";

  // Components
  Components.Mass vehicle(
    m=m,
    s(start=0, fixed=true),
    v(start=0, fixed=true)) "Vehicle body mass";
  
  Components.Spring spring(c=k) "Suspension spring";
  Components.Damper damper(d=c) "Suspension damper";
  
  Position groundMotion(
    s(start=0, fixed=true),
    v(start=0, fixed=true)) "Ground motion source";
  
  Sine roadDisturbance(
    amplitude=amplitude,
    f=f,
    phase=phase) "Road disturbance input";

equation
  // Mechanical connections
  connect(groundMotion.flange, spring.flange_a) "Ground to spring connection";
  connect(groundMotion.flange, damper.flange_a) "Ground to damper connection";
  connect(spring.flange_b, vehicle.flange_a) "Spring to vehicle connection";
  connect(damper.flange_b, vehicle.flange_a) "Damper to vehicle connection";
  
  // Input connection
  connect(roadDisturbance.y, groundMotion.s_ref) "Road disturbance to ground motion";

annotation (
  experiment(StopTime=10, Interval=0.01),
  Documentation(info="<html>
    <p>This model represents a simple quarter-car suspension system, consisting of:</p>
    <ul>
      <li>A vehicle body (sprung mass)</li>
      <li>A suspension spring</li>
      <li>A suspension damper</li>
      <li>A ground motion input representing road disturbances</li>
    </ul>
    <p>The model simulates the vehicle's response to sinusoidal road disturbances, 
    which can be used to analyze ride comfort and suspension performance.</p>
    <p>Key variables to observe:</p>
    <ul>
      <li><code>vehicle.s</code>: Vertical displacement of the vehicle body</li>
      <li><code>vehicle.v</code>: Vertical velocity of the vehicle body</li>
      <li><code>groundMotion.s</code>: Road profile (input disturbance)</li>
      <li><code>spring.f</code>: Force exerted by the suspension spring</li>
      <li><code>damper.f</code>: Force exerted by the suspension damper</li>
    </ul>
  </html>"),
  __OpenModelica_simulationFlags(lv="LOG_STATS", s="dassl"));
end MassSpringDamper;