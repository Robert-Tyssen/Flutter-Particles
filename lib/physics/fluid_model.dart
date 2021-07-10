import 'dart:async';

import 'dart:math';

import 'package:smooth_particle_flutter/physics/particle_model.dart';
import 'package:smooth_particle_flutter/physics/smoothing_kernels.dart';
import 'package:smooth_particle_flutter/physics/vec2_typedef.dart';

class FluidModel {

  // Particle id counter
  int _pid = 0;

  // Gravity
  static const g = Point<double>(0, 9.8);

  // Smoothing length
  final double h;

  // Density of fluid at rest
  final double restDensity;
  final double k = 0.5E-5; // TODO - better gas constant?

  // Simulation delta-time
  final Duration dt;
  Timer? timer;

  // Particles being simulated
  final particles = List<ParticleModel>.empty(growable: true);

  FluidModel({required this.h, required this.dt, this.restDensity = 1});

  void startSimulation() {
    timer = Timer.periodic(dt, (timer) { _simulationLoop(timer);});
  }

  void stopSimulation() {
    timer?.cancel();
  }

  void _simulationLoop(Timer dt) async {
    // Reset densities/forces each iteration
    particles.forEach((p) => p.clearDensityAndForces());

    _calculateDensities();
    _calculateForces();
    _calculatePositions();
  }

  void _calculateDensities() {
    // TODO - better neighbor lookup for performance
    particles.forEach((p) {
      particles.where((n) => n.id != p.id).forEach((n) {
        var dPos = p.position - n.position;
        if (dPos.magnitude <= h) {
          p.density += p.mass * poly6(dPos, h);
        }
      });
    });

  }

  void _calculateForces() {
    // TODO - better neighbor lookup for performance
    particles.forEach((p) {
      particles.where((n) => n.id != p.id).forEach((n) {
        var dPos = p.position - n.position;
        if (dPos.magnitude <= h) {
          var pp = k * (p.density - restDensity);
          var pn = k * (n.density - restDensity);
          p.pressureForce += spikyGradient(dPos, h) * (p.mass * (pp + pn) / (2 * n.density));
        }
      });
    });

    // TODO - proper boundary handling
    particles.forEach((p) {
      // Left
      if (p.position.x < h) if (p.position.x > 1 - h) p.position = Vec2(h, p.position.y);
      // Right
      if (p.position.x > 1 - h) p.position = Vec2(1-h, p.position.y);
      // Bottom
      if (p.position.y > 1 - h) p.position = Vec2(p.position.x, 1 - h);
      // Not implemented
    });

  }

  void _calculatePositions() {
    particles.forEach((element) {
      var acc = (element.pressureForce + element.viscosityForce + g) * (1.0 / element.mass);
      element.velocity += acc * (dt.inMilliseconds.toDouble() / 1000.0);
      element.velocity *= 0.9;// TODO - better friction loss handling to prevent craziness
      element.position += element.velocity * (dt.inMilliseconds.toDouble() / 1000.0);
    });
  }

  void addParticleAtPosition(double x, double y) {
    var pos = Point<double>(x, y);
    var id = _pid;
    _pid++;
    particles.add(
      ParticleModel(
        position: pos,
        id: id,
      ),
    );
  }

  List<Point<double>> getParticlePostions() {
    return particles.map((e) => Point<double>(e.position.x, e.position.y)).toList();
  }
}
