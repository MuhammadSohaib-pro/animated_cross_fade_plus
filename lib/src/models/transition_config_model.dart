import 'package:flutter/material.dart';

/// Configuration model for controlling transition animations.
///
/// This class defines various parameters that control how transitions
/// are performed, including animation curves, durations, and directions.
class TransitionConfig {
  /// The curve that defines the animation's rate of change over time.
  /// Default is [Curves.linear] for smooth, constant-rate animations.
  final Curve curve;

  /// The duration over which the transition animation occurs.
  /// Default is 300 milliseconds.
  final Duration duration;

  /// The axis direction for directional transitions (like slides).
  /// Default is [AxisDirection.right].
  final AxisDirection direction;

  /// Creates a transition configuration with optional parameters.
  ///
  /// All parameters have sensible defaults for common use cases.
  const TransitionConfig({
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 300),
    this.direction = AxisDirection.right,
  });
}

/// Defines the available types of cross-fade transitions.
///
/// These types determine how widgets transition between states.
enum CrossFadeTransitionType {
  /// Simple opacity fade transition
  fade,

  /// Sliding movement transition
  slide,

  /// Scaling size transition
  scale,

  /// Combined sliding and fading transition
  slideAndFade,
}
