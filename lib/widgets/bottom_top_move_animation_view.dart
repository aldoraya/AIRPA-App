import 'package:flutter/material.dart';

class BottomTopMoveAnimationView extends StatelessWidget {
  final AnimationController animationController;
  final Widget child;

  const BottomTopMoveAnimationView({
    Key? key,
    required this.animationController,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        child: child,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: animationController,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 40 * (1.0 - animationController.value), 0.0),
              child: child,
            ),
          );
        },
      );
  }
}
