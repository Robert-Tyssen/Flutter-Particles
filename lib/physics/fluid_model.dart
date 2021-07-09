import 'dart:async';

import 'dart:math';

import 'package:smooth_particle_flutter/physics/particle_model.dart';

class FluidModel {
  // Smoothing length
  final double h;

  // Simulation delta-time
  final Duration dt;

  // Particles being simulated
  final particles = List<ParticleModel>.empty(growable: true);

  FluidModel({required this.h, required this.dt});

  void startSimulation() {
    throw UnimplementedError();
  }

  void stopSimulation() {
    throw UnimplementedError();
  }

  void _simulationLoop(Timer dt) async {
    //_calculateDensities();
    //_calculateForces();
    //_calculatePositions();

    throw UnimplementedError();
  }

  void _calculateDensities(double dt) {
    throw UnimplementedError();
  }

  void _calculateForces(double dt) {
    throw UnimplementedError();
  }

  void _calculatePositions(double dt) {
    throw UnimplementedError();
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
