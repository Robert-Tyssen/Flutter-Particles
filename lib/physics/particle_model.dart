import 'dart:math';

class ParticleModel {

  static Point<double> get _zeroPoint => const Point<double>(0, 0);

  // Unique particle id
  final int id;

  // Mass [kg] and density [kg/m3] of particle
  double mass;

  // Density created by force of neighboring particles/boundaries
  double density;

  // Position [m], velocity[m/s] and force [N] vectors in (x, y) dims
  Point<double> position;
  Point<double> velocity;
  Point<double> pressureForce;
  Point<double> viscosityForce;

  ParticleModel({
    this.mass = 1,
    this.density = 1,
    required this.position,
    required this.id,
    this.velocity = const Point<double>(0, 0),
    this.pressureForce = const Point<double>(0, 0),
    this.viscosityForce = const Point<double>(0, 0),
  });

  void clearDensityAndForces() {
    density = 0;
    pressureForce = _zeroPoint;
    viscosityForce = _zeroPoint;
  }
}
