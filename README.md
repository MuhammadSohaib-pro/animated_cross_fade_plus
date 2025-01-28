# animated_cross_fade_plus

A Flutter package that provides an enhanced version of AnimatedCrossFade with support for multiple children and customizable animations.

## Features

- Support for multiple children (not just two like the original AnimatedCrossFade)
- Customizable animation duration and curve
- Auto-play functionality with configurable intervals
- Manual navigation through children
- Callback support for animation completion
- Alignment control for children
- Simple API similar to AnimatedCrossFade

## Getting started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  animated_cross_fade_plus: ^0.0.1
```

## Usage

```dart
import 'package:animated_cross_fade_plus/animated_cross_fade_plus.dart';

// Create a list of widgets to animate between
final List<Widget> children = [
  Container(color: Colors.red),
  Container(color: Colors.blue),
  Container(color: Colors.green),
];

// Basic usage
AnimatedCrossFadePlus(
  children: children,
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  initialIndex: 0,
)

// Auto-playing carousel
AnimatedCrossFadePlus(
  children: children,
  duration: const Duration(milliseconds: 300),
  autoPlay: true,
  autoPlayDuration: const Duration(seconds: 2),
)

// With manual control
final GlobalKey<_AnimatedCrossFadePlusState> _crossFadeKey = GlobalKey();

AnimatedCrossFadePlus(
  key: _crossFadeKey,
  children: children,
  onIndexChanged: (index) {
    print('Switched to index: $index');
  },
)

// Later, you can control the animations:
_crossFadeKey.currentState?.animateToNext(); // Go to next child
_crossFadeKey.currentState?.animateToIndex(2); // Go to specific index
```

## Parameters

- `children`: List of widgets to animate between
- `duration`: Duration of the cross-fade animation
- `curve`: Curve to use for the cross-fade animation
- `initialIndex`: Initial index of the child to display
- `autoPlay`: Whether to automatically cycle through children
- `autoPlayDuration`: Duration to wait between auto-play transitions
- `alignment`: Alignment of children within the cross-fade
- `excludeBottomFocus`: Whether to exclude the semantic boundary
- `onIndexChanged`: Callback function when the animation completes

## Additional information

For more examples, check out the example directory in the package repository.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
