import 'dart:math';
import 'package:smooth_particle_flutter/physics/vec2_typedef.dart';

double poly6(Point<double> dPos, double h) {

  double r = dPos.magnitude;

  if (r > h) {
    return 0;
  }

  double termA = 315 / 64 / pi / pow(h, 9);
  double termB = pow(h * h - r * r, 3).toDouble();

  return termA * termB;

}

Vec2 spikyGradient(Vec2 dPos, double h) {

  double r = dPos.magnitude;

  if (r == 0) {
    return Vec2(0, 0);
  }

  var mult = 1 * 45 / pi / r / pow(h, 6) * pow(h - r, 2);
  return dPos * mult;
  
}
