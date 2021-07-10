import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_particle_flutter/physics/fluid_model.dart';

class SimulationPainter extends CustomPainter {
  late final FluidModel sim;

  SimulationPainter({required this.sim});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.blue.shade300;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2.0;

    var path = Path()..lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.width), paint);

    
    // TODO - review particle rendering
    sim.getParticlePostions().forEach((pos) {
      canvas.drawCircle(
          Offset(pos.x * size.width, pos.y * size.height), sim.h / 2 * size.height, paint);
    });

    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
