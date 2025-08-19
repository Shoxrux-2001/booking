import 'package:dartz/dartz.dart';
import 'package:restaurant/core/app/errors/failures.dart';
import 'package:restaurant/features/auth/domain/entity/user_entity.dart';
import 'package:restaurant/features/auth/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repo;
  SignUpUseCase(this.repo);

  Future<Either<Failure, UserEntity>> call({
    required String name,
    required String email,
    required String password,
  }) => repo.signUp(name: name, email: email, password: password);
}
