import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entity/user_entity.dart'; // kerakli joydan import

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(UserEntity user) = _Authenticated;
  const factory AuthState.failure(String message) = _Failure;
}
