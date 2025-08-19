import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/features/auth/domain/usecases/google_sign_in_usecase.dart';
import 'package:restaurant/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:restaurant/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:restaurant/features/auth/presentation/bloc/auth_event.dart';
import 'package:restaurant/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final GoogleSignInUseCase googleSignInUseCase;

  AuthBloc({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.googleSignInUseCase,
  }) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.map(
        signUp: (e) async {
          emit(const AuthState.loading());
          final res = await signUpUseCase(
            name: e.name,
            email: e.email,
            password: e.password,
          );
          res.fold(
            (l) => emit(AuthState.failure(l.message)),
            (r) => emit(AuthState.authenticated(r)),
          );
        },
        signIn: (e) async {
          emit(const AuthState.loading());
          final res = await signInUseCase(email: e.email, password: e.password);
          res.fold(
            (l) => emit(AuthState.failure(l.message)),
            (r) => emit(AuthState.authenticated(r)),
          );
        },
        googleSignIn: (e) async {
          emit(const AuthState.loading());
          final res = await googleSignInUseCase();
          res.fold(
            (l) => emit(AuthState.failure(l.message)),
            (r) => emit(AuthState.authenticated(r)),
          );
        },
        reset: (e) async {
          emit(const AuthState.initial());
        },
      );
    });
  }
}
