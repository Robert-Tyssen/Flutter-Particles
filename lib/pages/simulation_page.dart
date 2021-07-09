import 'package:flutter/material.dart';
import 'package:smooth_particle_flutter/pages/simulation_painter.dart';

class SimulationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simulation Page')),
      body: Center(
        child: Container(
          height: 500,
          width: 500,
          child: CustomPaint(
            painter: SimulationPainter(),
          ),
        ),
      ),
    );
  }
}
