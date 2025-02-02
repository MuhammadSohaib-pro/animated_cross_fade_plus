import 'package:animated_cross_fade_plus/src/models/transition_config_model.dart';
import 'package:flutter/material.dart';
import 'package:animated_cross_fade_plus/src/transitions/transitions.dart';

/// A mixin that provides custom transition building capabilities.
/// This mixin is responsible for creating different types of transitions based on the specified configuration.
mixin CustomTransitionBuilder {
  /// Builds a transition widget based on the specified parameters.
  ///
  /// Parameters:
  /// - [type]: The type of cross-fade transition to apply
  /// - [animation]: The animation controller that drives the transition
  /// - [config]: Configuration parameters for the transition
  /// - [isEntering]: Whether the widget is entering (true) or exiting (false)
  /// - [child]: The widget to apply the transition to
  ///
  /// Returns a Widget with the specified transition applied.
  Widget buildTransition({
    required CrossFadeTransitionType type,
    required Animation<double> animation,
    required TransitionConfig config,
    required bool isEntering,
    required Widget child,
  }) {
    switch (type) {
      case CrossFadeTransitionType.slide:
        // Creates a sliding transition effect
        return SlideTransitionWidget(
          animation: animation,
          direction: config.direction,
          isEntering: isEntering,
          child: child,
        );
      case CrossFadeTransitionType.scale:
        // Creates a scaling transition effect
        return ScaleTransitionWidget(
          animation: animation,
          isEntering: isEntering,
          child: child,
        );
      case CrossFadeTransitionType.slideAndFade:
        // Combines sliding and fading effects
        return SlideAndFadeTransitionWidget(
          animation: animation,
          direction: config.direction,
          isEntering: isEntering,
          child: child,
        );
      default:
        // Falls back to a simple fade transition
        return FadeTransitionWidget(
          animation: animation,
          child: child,
        );
    }
  }
}
