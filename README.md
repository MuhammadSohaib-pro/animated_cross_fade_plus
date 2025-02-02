# Animated Cross Fade Plus

A powerful Flutter package that enhances the traditional AnimatedCrossFade widget with support for multiple children, auto-play capabilities, and smooth transitions.

[![pub package](https://img.shields.io/pub/v/animated_cross_fade_plus.svg)](https://pub.dev/packages/animated_cross_fade_plus) [![github](https://img.shields.io/static/v1?label=platform&message=flutter&color=1ebbfd)](https://github.com/MuhammadSohaib-pro/animated_cross_fade_plus) [![likes](https://img.shields.io/pub/likes/animated_cross_fade_plus?style=flat-square)](https://pub.dev/packages/animated_cross_fade_plus/score) [![license](https://img.shields.io/github/license/MuhammadSohaib-pro/animated_cross_fade_plus.svg)](https://github.com/MuhammadSohaib-pro/animated_cross_fade_plus/blob/master/LICENSE)

## Demo

### Auto-Play Carousel

![Auto-play Demo](https://raw.githubusercontent.com/MuhammadSohaib-pro/animated_cross_fade_plus/master/example/assets/auto_play_demo.gif)

### Manual Navigation

![Manual Navigation Demo](https://raw.githubusercontent.com/MuhammadSohaib-pro/animated_cross_fade_plus/master/example/assets/manual_demo.gif)

### Youtube Video

🎥 Check out the tutorial video on my YouTube channel to see it in action! [Youtube video](https://www.youtube.com/watch?v=iVYEFxbSD2w)

## Features 🚀

- ✨ Support for unlimited children (not just two like AnimatedCrossFade)
- 🎮 Manual navigation controls
- 🎯 Auto-play functionality
- 🎨 Multiple transition types (fade, slide, scale, slideAndFade)
- 📱 Separate enter and exit animations
- 🎭 Customizable transition configurations
- 🔄 Built-in play/pause controls
- 📍 Progress indicators

## Installation 💻

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  animated_cross_fade_plus: ^0.0.4
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
      children: _slides.map((slide) => _buildSlide(slide)).toList(),
      transitionType: CrossFadeTransitionType.scale,
      enterConfig: const TransitionConfig(
        curve: Curves.easeInOutCubic,
        duration: Duration(milliseconds: 1000),
      ),
      exitConfig: const TransitionConfig(
        curve: Curves.easeInOutCubic,
        duration: Duration(milliseconds: 1000),
      ),
      autoPlay: true,
      autoPlayDuration: const Duration(seconds: 3),
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
          children: _items.map((item) => _buildItem(item)).toList(),
          transitionType: CrossFadeTransitionType.slideAndFade,
          enterConfig: const TransitionConfig(
            curve: Curves.easeInOutCubic,
            duration: Duration(milliseconds: 800),
            direction: AxisDirection.left,
          ),
          exitConfig: const TransitionConfig(
            curve: Curves.easeInOutCubic,
            duration: Duration(milliseconds: 800),
            direction: AxisDirection.right,
          ),
          onIndexChanged: (index) => setState(() => _currentIndex = index),
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => _key.currentState?.animateToIndex((_currentIndex - 1) % _items.length),
              child: Text('Previous'),
            ),
            ElevatedButton(
              onPressed: () => _key.currentState?.animateToIndex((_currentIndex + 1) % _items.length),
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

| Parameter        | Type                    | Description                                     |
| ---------------- | ----------------------- | ----------------------------------------------- |
| children         | List<Widget>            | List of widgets to animate between              |
| transitionType   | CrossFadeTransitionType | Type of transition animation                    |
| enterConfig      | TransitionConfig        | Configuration for entering widget animation     |
| exitConfig       | TransitionConfig        | Configuration for exiting widget animation      |
| initialIndex     | int                     | Starting index                                  |
| autoPlay         | bool                    | Enable/disable auto-play                        |
| autoPlayDuration | Duration?               | Time between auto-play transitions              |
| alignment        | AlignmentGeometry       | Alignment of children                           |
| constraints      | BoxConstraints?         | Optional size constraints                       |
| clipChildren     | bool                    | Whether to clip children during animation       |
| onIndexChanged   | Function(int)?          | Callback when index changes                     |

## Transition Types 🎭

```dart
enum CrossFadeTransitionType {
  fade,           // Simple fade transition
  slide,          // Slide animation
  scale,          // Scale animation
  slideAndFade,   // Combined slide and fade
}
```

## TransitionConfig Properties 🛠️

```dart
class TransitionConfig {
  final Curve curve;              // Animation curve
  final Duration duration;        // Animation duration
  final AxisDirection direction;  // Slide direction (for slide transitions)

  const TransitionConfig({
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 300),
    this.direction = AxisDirection.right,
  });
}
```

## Controller Methods 🎮

```dart
final GlobalKey<AnimatedCrossFadePlusState> _key = GlobalKey();

// Navigation
_key.currentState?.animateToIndex(2);   // Navigate to specific index

// Auto-play control is handled through the autoPlay property
// Toggle by updating the widget's autoPlay value
```

## Complete Examples 📱

Check out the [example](https://github.com/MuhammadSohaib-pro/animated_cross_fade_plus/blob/master/example/lib/main.dart) folder for complete implementation examples:

- Auto-play carousel with scale transitions
- Manual navigation with slide and fade transitions
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
