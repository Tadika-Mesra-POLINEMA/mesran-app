import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mesran_app/src/features/authentication/domain/use_case/auth_use_case.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/auth_event.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase authUseCase;

  AuthBloc(
    this.authUseCase,
    FlutterSecureStorage flutterSecureStorage,
  ) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final response = await authUseCase.login(event.authRequest);

    response.fold(
      (error) => emit(AuthFailure(error.status, error.message)),
      (_) {
        emit(AuthSuccess());
      },
    );
  }
}
