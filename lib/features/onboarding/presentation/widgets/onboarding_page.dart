import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant/features/onboarding/data/models/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel onboardingModel;

  const OnboardingPage({super.key, required this.onboardingModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            onboardingModel.svgAsset,
            height: 200,
            width: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 30),
          Text(
            onboardingModel.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            onboardingModel.description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
