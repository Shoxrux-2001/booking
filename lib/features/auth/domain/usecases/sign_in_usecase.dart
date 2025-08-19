
import 'package:dartz/dartz.dart';
import 'package:restaurant/core/app/errors/failures.dart';
import 'package:restaurant/features/auth/domain/entity/user_entity.dart';
import 'package:restaurant/features/auth/domain/repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repo;
  SignInUseCase(this.repo);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) => repo.signIn(email: email, password: password);
}
