import 'dart:math';

class ParticleModel {

  static const Point _ZERO_POINT = Point<double>(0, 0);

  // Mass [kg] and density [kg/m3] of particle
  double mass;
  double density;

  // Added density created by neighboring particles
  double _additiveDensity = 0;

  // Position [m], velocity[m/s] and force [N] vectors in (x, y) dims
  Point<double> position;
  Point velocity;
  Point pressureForce;
  Point viscosityForce;

  ParticleModel({
    this.mass = 0.001,
    this.density = 1000,
    required this.position,
    this.velocity = _ZERO_POINT,
    this.pressureForce = _ZERO_POINT,
    this.viscosityForce = _ZERO_POINT,
  });
}
