import 'package:flutter/material.dart';
import 'package:animated_cross_fade_plus/animated_cross_fade_plus.dart';

class ManualCarouselExample extends StatefulWidget {
  const ManualCarouselExample({super.key});

  @override
  State<ManualCarouselExample> createState() => _ManualCarouselExampleState();
}

class _ManualCarouselExampleState extends State<ManualCarouselExample> {
  late final GlobalKey<AnimatedCrossFadePlusState> _crossFadeKey;
  int _currentIndex = 0;

  // Sample items for the carousel
  final List<String> _items = [
    'https://images.pexels.com/photos/1271619/pexels-photo-1271619.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/2207571/pexels-photo-2207571.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://media.istockphoto.com/id/1205214235/photo/path-through-sunlit-forest.jpg?s=612x612&w=0&k=20&c=-AS1aTz85kcZ2X7E8n2iFlm6dsdIMyWGWrSDQ1o-f_0=',
  ];

  @override
  void initState() {
    super.initState();
    _crossFadeKey = GlobalKey<AnimatedCrossFadePlusState>();
    // Ensure initial animation state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _currentIndex = 0;
      });
    });
  }

  void _handlePrevious() {
    final nextIndex = (_currentIndex - 1) % _items.length;
    _crossFadeKey.currentState?.animateToIndex(nextIndex);
  }

  void _handleNext() {
    final nextIndex = (_currentIndex + 1) % _items.length;
    _crossFadeKey.currentState?.animateToIndex(nextIndex);
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
      width: MediaQuery.of(context).size.width * 0.7,
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
                onPressed: _handlePrevious,
                child: const Text('Previous'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _handleNext,
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
