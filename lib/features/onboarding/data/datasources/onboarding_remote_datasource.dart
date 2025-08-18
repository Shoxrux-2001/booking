import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant/features/onboarding/data/models/onboarding_model.dart';

class OnboardingRemoteDataSource {
  final FirebaseFirestore firestore;

  OnboardingRemoteDataSource({required this.firestore});

  Future<List<OnboardingModel>> getOnboardingData() async {
    try {
      final snapshot = await firestore.collection('onboarding').get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return OnboardingModel(
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          svgAsset: data['svgAsset'] ?? '',
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch onboarding data: $e');
    }
  }
}