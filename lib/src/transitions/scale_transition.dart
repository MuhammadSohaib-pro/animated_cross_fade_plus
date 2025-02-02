import 'package:flutter/material.dart';

/// A widget that implements a scaling transition effect.
///
/// This widget creates a smooth scaling animation combined with an opacity effect,
/// making the content appear to grow/shrink while fading in/out.
class ScaleTransitionWidget extends StatelessWidget {
  /// The animation that drives the scale transition.
  final Animation<double> animation;

  /// Determines if the widget is entering (true) or exiting (false).
  final bool isEntering;

  /// The widget to which the scale transition will be applied.
  final Widget child;

  /// Creates a scale transition widget.
  ///
  /// All parameters are required and must not be null.
  const ScaleTransitionWidget({
    super.key,
    required this.animation,
    required this.isEntering,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isEntering ? animation.value : 1 - animation.value,
      duration:
          Duration.zero, // Instant update as animation is handled by parent
      child: AnimatedOpacity(
        opacity: isEntering ? animation.value : 1 - animation.value,
        duration: Duration.zero,
        child: child,
      ),
    );
  }
}
