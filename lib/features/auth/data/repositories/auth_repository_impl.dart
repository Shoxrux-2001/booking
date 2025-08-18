import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant/features/auth/data/services/auth_service.dart';
import 'package:restaurant/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<AppUser?> googleAuthenticate();
  Future<UserCredential> signUpUserWithEmailAndPassword(
    String email,
    String password,
  );
  Future<UserCredential> signInUserWithEmailAndPassword(
    String email,
    String password,
  );
  Future<void> logOutUser();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService = AuthService();

  @override
  Future<AppUser?> googleAuthenticate() async {
    return await _authService.googleAuthenticate();
  }

  @override
  Future<UserCredential> signUpUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _authService.signUpUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential> signInUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _authService.signInUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logOutUser() async {
    await _authService.logOutUser();
  }
}
