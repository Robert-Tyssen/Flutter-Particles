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
  final double k = 1000; // TODO - better gas constant?

  // Simulation delta-time
  final Duration dt;
  Timer? timer;

  // Particles being simulated
  final particles = List<ParticleModel>.empty(growable: true);

  FluidModel({required this.h, required this.dt, this.restDensity = 1000});

  void startSimulation() {
    timer = Timer.periodic(dt, (timer) { _simulationLoop(timer);});
  }

  void stopSimulation() {
    timer?.cancel();
  }

  void _simulationLoop(Timer dt) async {
    // Reset densities/forces each iteration
    particles.forEach((p) {p.clearDensityAndForces();});

    _calculateDensities();
    _calculateForces();
    _calculatePositions();
  }

  void _calculateDensities() {
    // TODO - better neighbor lookup for performance
    particles.forEach((p) {
      p.density = restDensity;
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

  }

  void _calculatePositions() {

    final  elapsedTime = dt.inMilliseconds.toDouble() / 1000.0;

    particles.forEach((element) {
      var acc = (element.pressureForce + element.viscosityForce) * (1.0 / element.density) * elapsedTime + g;
      element.velocity += acc * elapsedTime;
      if (element.velocity.magnitude > 1) element.velocity *= 1 / element.velocity.magnitude;
      element.position += element.velocity * (dt.inMilliseconds.toDouble() / 1000.0);

      //if (element.position.x < 0) element.position = Vec2(0, element.position.y);
      //if (element.position.x > 1) element.position = Vec2(1, element.position.y);

      if (element.position.x < 0) {
        element.position = Vec2(Random().nextDouble() * 0.0001, element.position.y);
        element.velocity = Vec2(0, element.velocity.y);
      }

      if (element.position.x > 1) {
        element.position = Vec2(1 - Random().nextDouble() * 0.0001, element.position.y);
        element.velocity = Vec2(0, element.velocity.y);
      }
      
      if (element.position.y > 1) {
        element.position = Vec2(element.position.x, 1 - Random().nextDouble() * 0.0001);
        element.velocity = Vec2(element.velocity.x, 0);
      }

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
