library animated_cross_fade_plus;

import 'package:flutter/material.dart';
import 'dart:async';

/// A widget that cross-fades between multiple children.
class AnimatedCrossFadePlus extends StatefulWidget {
  /// The list of children to display and animate between.
  final List<Widget> children;

  /// The duration of the cross-fade animation.
  final Duration duration;

  /// The curve to use for the cross-fade animation.
  final Curve curve;

  /// The initial index of the child to display.
  final int initialIndex;

  /// Whether to auto-play the animations.
  final bool autoPlay;

  /// The duration to wait between auto-play transitions.
  final Duration? autoPlayDuration;

  /// Alignment of the children within the cross-fade.
  final AlignmentGeometry alignment;

  /// Whether to exclude the semantic boundary.
  final bool excludeBottomFocus;

  /// Called when the animation completes.
  final void Function(int)? onIndexChanged;

  const AnimatedCrossFadePlus({
    super.key,
    required this.children,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.linear,
    this.initialIndex = 0,
    this.autoPlay = false,
    this.autoPlayDuration,
    this.alignment = Alignment.center,
    this.excludeBottomFocus = false,
    this.onIndexChanged,
  })  : assert(children.length > 0, 'Children must not be empty'),
        assert(initialIndex >= 0 && initialIndex < children.length,
            'Initial index must be within bounds of children list');

  @override
  AnimatedCrossFadePlusState createState() => AnimatedCrossFadePlusState();
}

class AnimatedCrossFadePlusState extends State<AnimatedCrossFadePlus>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late int _currentIndex;
  late int _nextIndex;
  Timer? _autoPlayTimer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _nextIndex = _currentIndex;
    _isPlaying = widget.autoPlay;

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    if (_isPlaying && widget.children.length > 1) {
      _setupAutoPlay();
    }
  }

  @override
  void didUpdateWidget(AnimatedCrossFadePlus oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.autoPlay != oldWidget.autoPlay) {
      _isPlaying = widget.autoPlay;
      if (_isPlaying) {
        _setupAutoPlay();
      } else {
        _autoPlayTimer?.cancel();
      }
    }
  }

  void _setupAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(
      widget.autoPlayDuration ?? const Duration(seconds: 2),
      (_) => animateToNext(),
    );
  }

  /// Stops the auto-play animation
  void stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _isPlaying = false;
  }

  /// Starts the auto-play animation
  void startAutoPlay() {
    _isPlaying = true;
    _setupAutoPlay();
  }

  /// Toggles the auto-play state
  void toggleAutoPlay() {
    if (_isPlaying) {
      stopAutoPlay();
    } else {
      startAutoPlay();
    }
  }

  /// Animates to the next child in the list.
  void animateToNext() {
    if (!mounted) return;
    setState(() {
      _currentIndex = _nextIndex;
      _nextIndex = (_nextIndex + 1) % widget.children.length;
    });
    _controller.forward(from: 0.0).then((_) {
      if (widget.onIndexChanged != null) {
        widget.onIndexChanged!(_nextIndex);
      }
    });
  }

  /// Animates to the previous child in the list.
  void animateToPrevious() {
    if (!mounted) return;
    setState(() {
      _currentIndex = _nextIndex;
      _nextIndex = (_nextIndex - 1 + widget.children.length) % widget.children.length;
    });
    _controller.forward(from: 0.0).then((_) {
      if (widget.onIndexChanged != null) {
        widget.onIndexChanged!(_nextIndex);
      }
    });
  }

  /// Animates to a specific index.
  void animateToIndex(int index) {
    if (!mounted || index == _currentIndex) return;
    assert(index >= 0 && index < widget.children.length);
    
    setState(() {
      _currentIndex = _nextIndex;
      _nextIndex = index;
    });
    _controller.forward(from: 0.0).then((_) {
      if (widget.onIndexChanged != null) {
        widget.onIndexChanged!(index);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          alignment: widget.alignment,
          children: [
            Opacity(
              opacity: 1 - _animation.value,
              child: widget.children[_currentIndex],
            ),
            Opacity(
              opacity: _animation.value,
              child: widget.children[_nextIndex],
            ),
          ],
        );
      },
    );
  }
}