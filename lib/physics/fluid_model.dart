import 'dart:async';

import 'dart:math';

import 'package:smooth_particle_flutter/physics/particle_model.dart';

class FluidModel {

  // Gravity
  static const g = Point<double>(0, 0.01);

  // Smoothing length
  final double h;

  // Simulation delta-time
  final Duration dt;
  Timer? timer;

  // Particles being simulated
  final particles = List<ParticleModel>.empty(growable: true);

  FluidModel({required this.h, required this.dt});

  void startSimulation() {
    timer = Timer.periodic(dt, (timer) { _simulationLoop(timer);});
  }

  void stopSimulation() {
    timer?.cancel();
  }

  void _simulationLoop(Timer dt) async {
    //_calculateDensities();
    //_calculateForces();
    _calculatePositions();
  }

  void _calculateDensities(double dt) {
    throw UnimplementedError();
  }

  void _calculateForces(double dt) {
    throw UnimplementedError();
  }

  void _calculatePositions() {
    particles.forEach((element) {
      var acc = (element.pressureForce + element.viscosityForce + g) * (1.0 / element.mass);
      element.velocity += acc * (dt.inMilliseconds.toDouble() / 1000.0);
      element.position += element.velocity * (dt.inMilliseconds.toDouble() / 1000.0);
    });
  }

  void addParticleAtPosition(double x, double y) {
    var pos = Point<double>(x, y);
    particles.add(
      ParticleModel(
        position: pos,
      ),
    );
  }

  List<Point<double>> getParticlePostions() {
    return particles.map((e) => Point<double>(e.position.x, e.position.y)).toList();
  }
}
