import 'package:flutter/material.dart';

/// A widget that implements a simple fade transition effect.
///
/// This widget creates a smooth opacity animation, making the content
/// fade in or out based on the animation value.
class FadeTransitionWidget extends StatelessWidget {
  /// The animation that drives the fade transition.
  final Animation<double> animation;

  /// The widget to which the fade transition will be applied.
  final Widget child;

  /// Creates a fade transition widget.
  ///
  /// All parameters are required and must not be null.
  const FadeTransitionWidget({
    super.key,
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: animation.value,
      duration:
          Duration.zero, // Instant update as animation is handled by parent
      child: child,
    );
  }
}
