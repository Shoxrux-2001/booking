import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant/gen/assets.gen.dart';
import 'package:restaurant/features/onboarding/data/models/onboarding_model.dart';
import 'package:restaurant/features/onboarding/data/repositories/onboarding_repository_impl.dart';

class OnboardingViewModel extends ChangeNotifier {
  final OnboardingRepositoryImpl repository;
  List<OnboardingModel> _onboardingData = [];
  int _currentPage = 0;
  bool _isLoading = false;
  String? _error;

  List<OnboardingModel> get onboardingData => _onboardingData;
  int get currentPage => _currentPage;
  bool get isLoading => _isLoading;
  String? get error => _error;

  OnboardingViewModel({required this.repository}) {
    fetchOnboardingData();
  }

  Future<void> fetchOnboardingData() async {
    try {
      _isLoading = true;
      notifyListeners();
      _onboardingData = await repository.getOnboardingData();
      if (_onboardingData.isEmpty) {
        _onboardingData = [
          OnboardingModel(
            title: "Nearby restaurants",
            description: "Default data loading failed.",
            svgAsset: Assets.svgs.location,
          ),
          OnboardingModel(
            title: "Select Favorites",
            description: "Default data.",
            svgAsset: Assets.svgs.order,
          ),
          OnboardingModel(
            title: "Good Food",
            description: "Default data.",
            svgAsset: Assets.svgs.food,
          ),
        ];
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void completeOnboarding(BuildContext context) {
    context.go('/success');
  }

  void skipOnboarding(BuildContext context) {
    context.go('/success');
  }
}
