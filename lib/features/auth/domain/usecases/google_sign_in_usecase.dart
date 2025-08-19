import 'package:dartz/dartz.dart';
import 'package:restaurant/core/app/errors/failures.dart';
import 'package:restaurant/features/auth/domain/entity/user_entity.dart';
import 'package:restaurant/features/auth/domain/repository/auth_repository.dart';

class GoogleSignInUseCase {
  final AuthRepository repo;
  GoogleSignInUseCase(this.repo);

  Future<Either<Failure, UserEntity>> call() => repo.signInWithGoogle();
}
