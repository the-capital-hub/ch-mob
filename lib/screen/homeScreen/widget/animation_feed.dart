import 'package:flutter/material.dart';

class AnimatedFeedItem extends StatelessWidget {
  final int index;
  final Widget child;

  const AnimatedFeedItem({Key? key, required this.index, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + (index * 10)), 
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 100), 
            child: Transform.scale(
              scale: 0.8 + (value * 0.2),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}
