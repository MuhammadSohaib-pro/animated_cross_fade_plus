import 'package:flutter/material.dart';

/// A widget that implements a sliding transition effect.
///
/// This widget creates a smooth sliding animation combined with an opacity effect.
/// The slide direction can be customized using the [direction] parameter.
class SlideTransitionWidget extends StatelessWidget {
  /// The animation that drives the transition.
  final Animation<double> animation;

  /// The direction in which the slide animation occurs.
  /// Can be up, down, left, or right.
  final AxisDirection direction;

  /// Determines if the widget is entering (true) or exiting (false).
  /// This affects the direction of the animation.
  final bool isEntering;

  /// The widget to which the transition will be applied.
  final Widget child;

  /// Creates a slide transition widget.
  ///
  /// All parameters are required and must not be null.
  const SlideTransitionWidget({
    super.key,
    required this.animation,
    required this.direction,
    required this.isEntering,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _calculateOffset(),
      duration:
          Duration.zero, // Instant update as animation is handled by parent
      child: AnimatedOpacity(
        opacity: isEntering ? animation.value : 1 - animation.value,
        duration: Duration.zero,
        child: child,
      ),
    );
  }

  /// Calculates the offset for the slide animation based on the direction and animation state.
  ///
  /// Returns an [Offset] that determines the position of the sliding widget.
  Offset _calculateOffset() {
    final double value = 1 - animation.value;
    switch (direction) {
      case AxisDirection.up:
        return Offset(0, isEntering ? value : -value);
      case AxisDirection.down:
        return Offset(0, isEntering ? -value : value);
      case AxisDirection.left:
        return Offset(isEntering ? value : -value, 0);
      case AxisDirection.right:
        return Offset(isEntering ? -value : value, 0);
    }
  }
}
