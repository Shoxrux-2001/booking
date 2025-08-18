import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:restaurant/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:restaurant/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:restaurant/features/onboarding/presentation/viewmodels/onboarding_viewmodel.dart';

final onboardingRoutes = [
  GoRoute(
    path: '/onboarding',
    builder: (context, state) => ChangeNotifierProvider(
      create: (context) => OnboardingViewModel(
        repository: OnboardingRepositoryImpl(
          remoteDataSource: OnboardingRemoteDataSource(
            firestore: FirebaseFirestore.instance,
          ),
        ),
      ),
      child: const OnboardingScreen(),
    ),
  ),
];