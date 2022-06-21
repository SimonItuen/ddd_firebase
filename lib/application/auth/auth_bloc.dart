import 'package:ddd_firebase/domain/auth/i_auth_facade.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade;

  AuthBloc(this._authFacade) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async{
        if(event == const AuthEvent.authCheckRequested()){
        final userOption = await _authFacade.getSignedInUser();
        userOption.fold(() => emit(const AuthState.unAuthenticated()), (a) => emit(const AuthState.authenticated()));
      }
        if(event == const AuthEvent.signedOut()){
          await _authFacade.signOut();
          emit(const AuthState.unAuthenticated());
        }
    });
  }
}
