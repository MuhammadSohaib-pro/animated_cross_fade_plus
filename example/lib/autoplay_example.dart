// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:animated_cross_fade_plus/animated_cross_fade_plus.dart';

class AutoPlayCarouselExample extends StatefulWidget {
  const AutoPlayCarouselExample({super.key});

  @override
  State<AutoPlayCarouselExample> createState() => _AutoPlayCarouselExampleState();
}

class _AutoPlayCarouselExampleState extends State<AutoPlayCarouselExample> {
  int _currentIndex = 0;
  bool _isPlaying = true;
  final GlobalKey<AnimatedCrossFadePlusState> _crossFadeKey = GlobalKey();

  final List<SlideContent> _slides = [
    SlideContent(
      title: 'Welcome to Our App',
      description: 'Discover amazing features and possibilities',
      gradient: [Colors.purple, Colors.blue],
      icon: Icons.rocket_launch,
    ),
    SlideContent(
      title: 'Easy to Use',
      description: 'Intuitive interface designed for you',
      gradient: [Colors.orange, Colors.red],
      icon: Icons.touch_app,
    ),
    SlideContent(
      title: 'Secure & Fast',
      description: 'Your data is safe with us',
      gradient: [Colors.green, Colors.teal],
      icon: Icons.security,
    ),
    SlideContent(
      title: 'Get Started Now',
      description: 'Join thousands of happy users',
      gradient: [Colors.blue, Colors.indigo],
      icon: Icons.double_arrow_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto-Play Carousel'),
        actions: [
          IconButton(
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              setState(() {
                _isPlaying = !_isPlaying;
                if (_isPlaying) {
                  _crossFadeKey.currentState?.startAutoPlay();
                } else {
                  _crossFadeKey.currentState?.stopAutoPlay();
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedCrossFadePlus(
              key: _crossFadeKey,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOutCubic,
              initialIndex: _currentIndex,
              autoPlay: _isPlaying,
              autoPlayDuration: const Duration(seconds: 3),
              onIndexChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: _slides.map((slide) => _buildSlide(slide)).toList(),
            ),
          ),
          _buildProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildSlide(SlideContent slide) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: slide.gradient,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                slide.icon,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 32),
              Text(
                slide.title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                slide.description,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _slides.length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _currentIndex == index ? 24.0 : 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: _currentIndex == index
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }
}

class SlideContent {
  final String title;
  final String description;
  final List<Color> gradient;
  final IconData icon;

  SlideContent({
    required this.title,
    required this.description,
    required this.gradient,
    required this.icon,
  });
}