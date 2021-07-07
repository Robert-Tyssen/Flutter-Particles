import 'dart:math';

double poly6(double r, double h) {
  return (0 <= r && r <= h) ? 315.0 / 64.0 / pi / pow(h, 9) * pow(h * h - r * r, 3) : 0;
}
