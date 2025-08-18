import 'package:restaurant/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:restaurant/features/onboarding/data/models/onboarding_model.dart';

abstract class OnboardingRepository {
  Future<List<OnboardingModel>> getOnboardingData();
}

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingRemoteDataSource remoteDataSource;

  OnboardingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<OnboardingModel>> getOnboardingData() async {
    return await remoteDataSource.getOnboardingData();
  }
}