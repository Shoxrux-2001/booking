import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant/gen/assets.gen.dart';
import 'package:restaurant/features/onboarding/data/models/onboarding_model.dart';

class OnboardingDataInitializer {
  final FirebaseFirestore firestore;

  OnboardingDataInitializer({required this.firestore});

  Future<void> initializeOnboardingData() async {
    try {
      final collection = firestore.collection('onboarding');
      final snapshot = await collection.get();
      if (snapshot.docs.isEmpty) {
        final defaultData = [
          OnboardingModel(
            title: "Nearby restaurants",
            description: "Discover restaurants near you.",
            svgAsset: Assets.svgs.location,
          ),
          OnboardingModel(
            title: "Select Favorites",
            description: "Choose your favorite dishes.",
            svgAsset: Assets.svgs.order,
          ),
          OnboardingModel(
            title: "Good Food",
            description: "Enjoy delicious meals.",
            svgAsset: Assets.svgs.food,
          ),
        ];

        for (var data in defaultData) {
          await collection.add({
            'title': data.title,
            'description': data.description,
            'svgAsset': data.svgAsset,
          });
        }
      }
    } catch (e) {
      throw Exception('Failed to initialize onboarding data: $e');
    }
  }
}