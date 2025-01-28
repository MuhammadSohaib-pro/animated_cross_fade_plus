// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:animated_cross_fade_plus/animated_cross_fade_plus.dart';

class ManualCarouselExample extends StatefulWidget {
  const ManualCarouselExample({super.key});

  @override
  State<ManualCarouselExample> createState() => _ManualCarouselExampleState();
}

class _ManualCarouselExampleState extends State<ManualCarouselExample> {
  final GlobalKey<AnimatedCrossFadePlusState> _crossFadeKey = GlobalKey();
  int _currentIndex = 0;

  // Sample items for the carousel
  final List<String> _items = [
    'https://images.pexels.com/photos/1271619/pexels-photo-1271619.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/2207571/pexels-photo-2207571.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://media.istockphoto.com/id/1205214235/photo/path-through-sunlit-forest.jpg?s=612x612&w=0&k=20&c=-AS1aTz85kcZ2X7E8n2iFlm6dsdIMyWGWrSDQ1o-f_0=',
  ];

  void _handlePrevious() {
    if (_currentIndex > 0) {
      _crossFadeKey.currentState?.animateToPrevious();
    }
  }

  void _handleNext() {
    if (_currentIndex < _items.length - 1) {
      _crossFadeKey.currentState?.animateToNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual Carousel'),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedCrossFadePlus(
              key: _crossFadeKey,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOutCubic,
              initialIndex: _currentIndex,
              onIndexChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: _items.map((item) => _buildCarouselItem(item)).toList(),
            ),
          ),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(String url) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
      margin: const EdgeInsets.all(16),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _currentIndex > 0 ? _handlePrevious : null,
                child: const Text('Previous'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed:
                    _currentIndex < _items.length - 1 ? _handleNext : null,
                child: const Text('Next'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Dots indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _items.length,
              (index) => GestureDetector(
                onTap: () => _crossFadeKey.currentState?.animateToIndex(index),
                child: Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
