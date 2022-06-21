part of 'sign_in_form_bloc.dart';

// all possible things
@freezed
class SignInFormEvent with _$SignInFormEvent {
  const factory SignInFormEvent.emailChanged(String emailStr) = EmailChanged;
  const factory SignInFormEvent.passwordChanged(String passwordStr) = PasswordChanged;
  const factory SignInFormEvent.registerWithEmailAndPassword() = RegisterWithEmailPasswordPressed;
  const factory SignInFormEvent.signInWithEmailAndPassword() = SignInWithEmailAndPassword;
  const factory SignInFormEvent.signInWithGooglePressed() = SignInWithGooglePressed;

}