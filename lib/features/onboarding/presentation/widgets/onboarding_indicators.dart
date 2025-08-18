import 'package:flutter/material.dart';

class OnboardingIndicators extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const OnboardingIndicators({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentIndex == index ? 12 : 8,
          height: currentIndex == index ? 12 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? Colors.green : Colors.grey[300],
          ),
        );
      }),
    );
  }
}
