import 'dart:async';

import 'package:meta/meta.dart';

class FluidModel {

  // Smoothing length
  final double h;

  // Simulation delta-time
  final Duration dt;


  FluidModel({@required this.h, @required this.dt});

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
    throw UnimplementedError();
  }

}