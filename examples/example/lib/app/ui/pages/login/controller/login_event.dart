import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.freezed.dart';

@freezed
class LoginEvent with _$LoginEvent {
  factory LoginEvent.emailChanged(String email) = LoginEventEmailChanged;
  factory LoginEvent.passwordChanged(String password) =
      LoginEventPasswordChanged;
}
