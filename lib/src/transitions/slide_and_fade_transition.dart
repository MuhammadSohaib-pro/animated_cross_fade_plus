import 'package:flutter/material.dart';
import 'slide_transition.dart';

/// A widget that combines sliding and fading transition effects.
///
/// This widget creates a smooth animation that both slides and fades the content
/// simultaneously, creating a more dynamic transition effect.
class SlideAndFadeTransitionWidget extends StatelessWidget {
  /// The animation that drives both the slide and fade transitions.
  final Animation<double> animation;

  /// The direction in which the slide animation occurs.
  final AxisDirection direction;

  /// Determines if the widget is entering (true) or exiting (false).
  final bool isEntering;

  /// The widget to which the transitions will be applied.
  final Widget child;

  /// Creates a slide and fade transition widget.
  ///
  /// All parameters are required and must not be null.
  const SlideAndFadeTransitionWidget({
    super.key,
    required this.animation,
    required this.direction,
    required this.isEntering,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransitionWidget(
      animation: animation,
      direction: direction,
      isEntering: isEntering,
      child: AnimatedOpacity(
        opacity: animation.value,
        duration: Duration.zero,
        child: child,
      ),
    );
  }
}
