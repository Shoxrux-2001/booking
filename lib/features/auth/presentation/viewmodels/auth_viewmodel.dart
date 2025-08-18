import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:restaurant/features/auth/data/models/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepositoryImpl repository = AuthRepositoryImpl();
  bool _isLoading = false;
  String? _error;
  AppUser? _user;

  bool get isLoading => _isLoading;
  String? get error => _error;
  AppUser? get user => _user;

  Future<void> googleAuthenticate(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _user = await repository.googleAuthenticate();
      if (_user != null) {
        context.go('/home');
      } else {
        _error = "Failed to authenticate with Google";
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUpUserWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await repository.signUpUserWithEmailAndPassword(email, password);
      context.go('/home');
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInUserWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await repository.signInUserWithEmailAndPassword(email, password);
      context.go('/home');
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logOutUser() async {
    await repository.logOutUser();
    _user = null;
    notifyListeners();
  }
}
