import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant/core/app/errors/failures.dart';
import 'package:restaurant/features/auth/data/source/firebase_auth_datasource.dart';
import 'package:restaurant/features/auth/domain/entity/user_entity.dart';
import 'package:restaurant/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  AuthRepositoryImpl({required this.remote});

  UserEntity _mapUser(User u) => UserEntity(
    uid: u.uid,
    displayName: u.displayName,
    email: u.email ?? '',
    photoUrl: u.photoURL,
  );

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final u = await remote.signIn(email: email, password: password);
      return Right(_mapUser(u));
    } on FirebaseAuthException catch (e) {
      return Left(Failure(e.message ?? 'Auth error'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final u = await remote.signInWithGoogle();
      return Right(_mapUser(u));
    } on FirebaseAuthException catch (e) {
      return Left(Failure(e.message ?? 'Auth error'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final u = await remote.signUp(
        name: name,
        email: email,
        password: password,
      );
      return Right(_mapUser(u));
    } on FirebaseAuthException catch (e) {
      return Left(Failure(e.message ?? 'Auth error'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
