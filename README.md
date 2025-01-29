# Animated Cross Fade Plus

A powerful Flutter package that enhances the traditional AnimatedCrossFade widget with support for multiple children, auto-play capabilities, and smooth transitions.

[![pub package](https://img.shields.io/pub/v/animated_cross_fade_plus.svg)](https://pub.dev/packages/animated_cross_fade_plus)
[![likes](https://img.shields.io/pub/likes/animated_cross_fade_plus?style=flat-square)](https://pub.dev/packages/animated_cross_fade_plus/score)
[![popularity](https://img.shields.io/pub/popularity/animated_cross_fade_plus?style=flat-square)](https://pub.dev/packages/animated_cross_fade_plus/score)

## Demo

### Auto-Play Carousel

![Auto-play Demo](https://raw.githubusercontent.com/MuhammadSohaib-pro/animated_cross_fade_plus/master/example/assets/auto_play_demo.gif)

### Manual Navigation

![Manual Navigation Demo](https://raw.githubusercontent.com/MuhammadSohaib-pro/animated_cross_fade_plus/master/example/assets/manual_demo.gif)

## Features 🚀

- ✨ Support for unlimited children (not just two like AnimatedCrossFade)
- 🎮 Manual navigation controls
- 🎯 Auto-play functionality
- 🎨 Customizable animations and durations
- 📱 Responsive design
- 🎭 Smooth cross-fade transitions
- 🔄 Built-in play/pause controls
- 📍 Progress indicators

## Installation 💻

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  animated_cross_fade_plus: ^0.0.1
```

## Usage 🎯

### Basic Auto-Play Carousel

```dart
class AutoPlayExample extends StatefulWidget {
  @override
  _AutoPlayExampleState createState() => _AutoPlayExampleState();
}

class _AutoPlayExampleState extends State<AutoPlayExample> {
  final List<SlideContent> _slides = [
    SlideContent(
      title: 'Welcome',
      gradient: [Colors.purple, Colors.blue],
      icon: Icons.rocket_launch,
    ),
    SlideContent(
      title: 'Easy to Use',
      gradient: [Colors.orange, Colors.red],
      icon: Icons.touch_app,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFadePlus(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOutCubic,
      autoPlay: true,
      autoPlayDuration: const Duration(seconds: 3),
      children: _slides.map((slide) => _buildSlide(slide)).toList(),
    );
  }
}
```

### Manual Navigation Carousel

```dart
class ManualExample extends StatefulWidget {
  @override
  _ManualExampleState createState() => _ManualExampleState();
}

class _ManualExampleState extends State<ManualExample> {
  final GlobalKey<AnimatedCrossFadePlusState> _key = GlobalKey();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedCrossFadePlus(
          key: _key,
          duration: const Duration(milliseconds: 800),
          children: _items.map((item) => _buildItem(item)).toList(),
          onIndexChanged: (index) => setState(() => _currentIndex = index),
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => _key.currentState?.animateToPrevious(),
              child: Text('Previous'),
            ),
            ElevatedButton(
              onPressed: () => _key.currentState?.animateToNext(),
              child: Text('Next'),
            ),
          ],
        ),
      ],
    );
  }
}
```

## Parameters ⚙️

| Parameter        | Type              | Description                          |
| ---------------- | ----------------- | ------------------------------------ |
| children         | List<Widget>      | List of widgets to animate between   |
| duration         | Duration          | Duration of the cross-fade animation |
| curve            | Curve             | Animation curve to use               |
| initialIndex     | int               | Starting index                       |
| autoPlay         | bool              | Enable/disable auto-play             |
| autoPlayDuration | Duration?         | Time between auto-play transitions   |
| alignment        | AlignmentGeometry | Alignment of children                |
| onIndexChanged   | Function(int)?    | Callback when index changes          |

## Controller Methods 🎮

```dart
final GlobalKey<AnimatedCrossFadePlusState> _key = GlobalKey();

// Navigation
_key.currentState?.animateToNext();     // Go to next slide
_key.currentState?.animateToPrevious(); // Go to previous slide
_key.currentState?.animateToIndex(2);   // Go to specific index

// Auto-play control
_key.currentState?.startAutoPlay();     // Start auto-play
_key.currentState?.stopAutoPlay();      // Stop auto-play
_key.currentState?.toggleAutoPlay();    // Toggle auto-play state
```

## Complete Examples 📱

Check out the [example](https://github.com/MuhammadSohaib-pro/animated_cross_fade_plus/blob/master/example/lib/main.dart) folder for complete implementation examples:

- Auto-play carousel with gradients and icons
- Manual navigation with image gallery
- Progress indicators
- Play/pause controls

## Contributing 🤝

Contributions are welcome! Please feel free to submit issues and pull requests.

1. Fork it
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit changes (`git commit -am 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing`)
5. Open a Pull Request

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Maintainers 👥

- [Muhammad Sohaib](https://github.com/MuhammadSohaib-pro) - creator and maintainer
