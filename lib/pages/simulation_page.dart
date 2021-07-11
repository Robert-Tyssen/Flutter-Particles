import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_particle_flutter/pages/simulation_painter.dart';
import 'package:smooth_particle_flutter/physics/fluid_model.dart';

class SimulationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SimulationState();
}

class _SimulationState extends State<SimulationPage> {

  late FluidModel _sim;

  _SimulationState() {
    _sim = FluidModel(h: 0.05, dt: Duration(milliseconds: 8));

    List.generate(
      200,
      (index) => _sim.addParticleAtPosition(
        Random().nextDouble(),
        Random().nextDouble(),
      ),
    );
    _sim.startSimulation();
  }

  @override
  void initState() {
    Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simulation Page')),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            child: CustomPaint(
              painter: SimulationPainter(sim: _sim),
            ),
          ),
        ),
      ),
    );
  }
}
