import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/core/services/auth_service.dart';
import 'package:restaurant/features/onboarding/presentation/viewmodels/onboarding_viewmodel.dart';
import 'package:restaurant/features/onboarding/presentation/widgets/onboarding_indicators.dart';
import 'package:restaurant/features/onboarding/presentation/widgets/onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OnboardingViewModel>(context);
    final PageController pageController = PageController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: viewModel.onboardingData.length,
                      onPageChanged: (index) {
                        viewModel.setCurrentPage(index);
                      },
                      itemBuilder: (context, index) {
                        return OnboardingPage(
                          onboardingModel: viewModel.onboardingData[index],
                        );
                      },
                    ),
                  ),
                  OnboardingIndicators(
                    itemCount: viewModel.onboardingData.length,
                    currentIndex: viewModel.currentPage,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () async {
                            await AuthService.markOnboardingCompleted();
                            viewModel.skipOnboarding(context);
                          },
                          child: const Text(
                            'Skip',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (viewModel.currentPage ==
                                viewModel.onboardingData.length - 1) {
                              await AuthService.markOnboardingCompleted();
                              viewModel.completeOnboarding(context);
                            } else {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(120, 50),
                          ),
                          child: Text(
                            viewModel.currentPage ==
                                    viewModel.onboardingData.length - 1
                                ? 'Finish'
                                : 'Next',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
      ),
    );
  }
}
