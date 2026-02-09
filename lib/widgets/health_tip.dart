import 'package:flutter/material.dart';

class HealthTipCarousel extends StatefulWidget {
  const HealthTipCarousel({super.key});

  @override
  State<HealthTipCarousel> createState() => _HealthTipCarouselState();
}

class _HealthTipCarouselState extends State<HealthTipCarousel> {
  final List<Map<String, String>> tips = [
    {
      'title': 'Stay Hydrated',
      'description': 'Drink at least 8 glasses of water daily to maintain optimal health.'
    },
    {
      'title': 'Exercise Regularly',
      'description': 'Aim for 30 minutes of moderate exercise 5 days a week.'
    },
    {
      'title': 'Balanced Diet',
      'description': 'Include fruits, vegetables, and whole grains in your meals.'
    },
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), _nextTip);
  }

  void _nextTip() {
    if (mounted) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % tips.length;
      });
      Future.delayed(const Duration(seconds: 5), _nextTip);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              tips[_currentIndex]['title']!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
            ),
            const SizedBox(height: 5),
            Text(
              tips[_currentIndex]['description']!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}