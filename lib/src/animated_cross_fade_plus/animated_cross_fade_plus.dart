import 'package:animated_cross_fade_plus/src/models/transition_config_model.dart';
import 'package:animated_cross_fade_plus/src/utils/custom_transition_builder.dart';
import 'package:flutter/material.dart';
import 'dart:async';

/// A widget that cross-fades between multiple children with customizable transitions.
///
/// This widget provides enhanced functionality over Flutter's built-in AnimatedCrossFade,
/// supporting multiple children, various transition types, and auto-play capabilities.
class AnimatedCrossFadePlus extends StatefulWidget {
  /// The list of widgets to display and transition between.
  /// Must contain at least one widget.
  final List<Widget> children;

  /// The type of transition to use when switching between children.
  /// Defaults to [CrossFadeTransitionType.fade].
  final CrossFadeTransitionType transitionType;

  /// Configuration for the entering widget's transition.
  final TransitionConfig enterConfig;

  /// Configuration for the exiting widget's transition.
  final TransitionConfig exitConfig;

  /// The index of the initially displayed child.
  /// Must be valid within the children list.
  final int initialIndex;

  /// Whether to automatically cycle through children.
  final bool autoPlay;

  /// Duration between auto-play transitions.
  /// If null and autoPlay is true, defaults to 2 seconds.
  final Duration? autoPlayDuration;

  /// Alignment of children within the cross-fade widget.
  final AlignmentGeometry alignment;

  /// Optional size constraints for the widget.
  final BoxConstraints? constraints;

  /// Whether to clip children that overflow the widget's bounds.
  final bool clipChildren;

  /// Callback function called when the displayed child index changes.
  final void Function(int)? onIndexChanged;

  /// Creates an AnimatedCrossFadePlus widget.
  ///
  /// At least one child must be provided in [children], and [initialIndex]
  /// must be valid within the children list.
  AnimatedCrossFadePlus({
    super.key,
    required this.children,
    this.transitionType = CrossFadeTransitionType.fade,
    this.enterConfig = const TransitionConfig(),
    this.exitConfig = const TransitionConfig(),
    this.initialIndex = 0,
    this.autoPlay = false,
    this.autoPlayDuration,
    this.alignment = Alignment.center,
    this.constraints,
    this.clipChildren = true,
    this.onIndexChanged,
  })  : assert(children.isNotEmpty, 'At least one child required'),
        assert(initialIndex >= 0 && initialIndex < children.length,
            'Invalid initial index');

  @override
  AnimatedCrossFadePlusState createState() => AnimatedCrossFadePlusState();
}

/// State class for AnimatedCrossFadePlus.
///
/// Manages the animation controller, transitions between children, and auto-play functionality.
class AnimatedCrossFadePlusState extends State<AnimatedCrossFadePlus>
    with SingleTickerProviderStateMixin, CustomTransitionBuilder {
  /// Controller for the cross-fade animation
  late final AnimationController _controller;

  /// Index of the currently displayed child
  late int _currentIndex;

  /// Index of the next child to display
  late int _nextIndex;

  /// Timer for auto-play functionality
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _nextIndex = _currentIndex;
    _controller = AnimationController(
      duration: _longestDuration,
      vsync: this,
    )..value = 1.0;
    if (widget.autoPlay && widget.children.length > 1) _startAutoPlay();
  }

  /// Returns the longer duration between enter and exit configurations
  Duration get _longestDuration =>
      widget.enterConfig.duration > widget.exitConfig.duration
          ? widget.enterConfig.duration
          : widget.exitConfig.duration;

  /// Starts the auto-play timer if enabled
  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(
      widget.autoPlayDuration ?? const Duration(seconds: 2),
      (_) => _animateToNext(),
    );
  }

  /// Animates to the next child in the list
  void _animateToNext() {
    if (!mounted || widget.children.length == 1) return;
    final nextIndex = (_nextIndex + 1) % widget.children.length;
    _animateTo(nextIndex);
  }

  /// Public method to animate to a specific child index
  void animateToIndex(int index) {
    if (!mounted || index == _nextIndex) return;
    _animateTo(index);
  }

  /// Internal method to handle animation to a specific index
  void _animateTo(int index) {
    setState(() {
      _currentIndex = _nextIndex;
      _nextIndex = index;
    });
    _controller
      ..reset()
      ..forward().then((_) => widget.onIndexChanged?.call(_nextIndex));
  }

  @override
  void dispose() {
    _controller.dispose();
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.constraints?.maxWidth,
      height: widget.constraints?.maxHeight,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Stack(
            alignment: widget.alignment,
            clipBehavior: widget.clipChildren ? Clip.hardEdge : Clip.none,
            children: [
              _buildTransition(
                widget.children[_currentIndex],
                isEntering: false,
              ),
              _buildTransition(
                widget.children[_nextIndex],
                isEntering: true,
              ),
            ],
          );
        },
      ),
    );
  }

  /// Builds a transition for a child widget
  ///
  /// [child] is the widget to transition
  /// [isEntering] determines if this is an entering or exiting transition
  Widget _buildTransition(Widget child, {required bool isEntering}) {
    final config = isEntering ? widget.enterConfig : widget.exitConfig;
    final animation = CurvedAnimation(
      parent: _controller,
      curve: config.curve,
      reverseCurve: config.curve.flipped,
    );

    return buildTransition(
      type: widget.transitionType,
      animation: animation,
      config: config,
      isEntering: isEntering,
      child: child,
    );
  }
}
