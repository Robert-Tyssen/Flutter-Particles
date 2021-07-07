import 'dart:math';

class ParticleModel {
  // Mass [kg] and density [kg/m3] of particle
  double mass;
  double density;

  // Added density created by neighboring particles
  double additiveDensity;

  // Position [m], velocity[m/s] and force [N] vectors in (x, y) dims
  Point position;
  Point velocity;
  Point pressureForce;
  Point viscosityForce;
}
