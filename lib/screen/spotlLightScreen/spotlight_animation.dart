import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedSwingingSpotlight extends StatefulWidget {
  const AnimatedSwingingSpotlight({super.key});

  @override
  State<AnimatedSwingingSpotlight> createState() =>
      _AnimatedSwingingSpotlightState();
}

class _AnimatedSwingingSpotlightState extends State<AnimatedSwingingSpotlight>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _swingAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600), // 💨 faster
      vsync: this,
    )..repeat(reverse: true);

    _swingAnimation = Tween<double>(begin: -0.8, end: 0.8) // 🌊 wider swing
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _swingAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: SwingingSpotlightPainter(_swingAnimation.value),
          child: Container(),
        );
      },
    );
  }
}

class SwingingSpotlightPainter extends CustomPainter {
  final double angle;

  SwingingSpotlightPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset topCenter = Offset(size.width / 2, 0);
    final double beamLength = size.height;
    final double spread = 100; // adjust if you want wider base

    final double dx = sin(angle) * spread;

    final Offset leftBottom = Offset(topCenter.dx - dx - spread, beamLength);
    final Offset rightBottom = Offset(topCenter.dx - dx + spread, beamLength);

    final Path conePath = Path()
      ..moveTo(topCenter.dx, topCenter.dy)
      ..lineTo(leftBottom.dx, leftBottom.dy)
      ..lineTo(rightBottom.dx, rightBottom.dy)
      ..close();

    final Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.3),
          Colors.transparent,
        ],
      ).createShader(
          Rect.fromPoints(topCenter, Offset(topCenter.dx, beamLength)));

    canvas.drawPath(conePath, paint);
  }

  @override
  bool shouldRepaint(covariant SwingingSpotlightPainter oldDelegate) =>
      oldDelegate.angle != angle;
}
