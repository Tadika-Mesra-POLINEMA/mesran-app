import 'package:bloc/bloc.dart';
import 'package:mesran_app/src/features/profiles/domain/entity/private_request.dart';
import 'package:mesran_app/src/features/profiles/domain/use_case/update_private_use_case.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/private_event.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/private_state.dart';

class PrivateBloc extends Bloc<PrivateEvent, PrivateState> {
  final UpdatePrivateUseCase updatePrivateUseCase;

  PrivateBloc(this.updatePrivateUseCase) : super(PrivateInitial()) {
    on<UpdatePrivate>(_onUpdatePrivate);
    on<EmailChanged>(_onEmailChange);
    on<OldPasswordChanged>(_onOldPasswordChange);
    on<NewPasswordChanged>(_onNewPasswordChange);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChange);
  }

  Future<void> _onUpdatePrivate(
    UpdatePrivate event,
    Emitter<PrivateState> emit,
  ) async {
    emit(PrivateLoading());

    final request = PrivateRequest(
      email: event.email,
      oldPassword: event.oldPassword,
      newPassword: event.newPassword,
      confirmPassword: event.confirmPassword,
    );

    final result = await updatePrivateUseCase(request);
    if (result) {
      emit(PrivateSuccess());
    } else {
      emit(PrivateFailure('Update Private gagal'));
    }
  }

  void _onEmailChange(EmailChanged event, Emitter<PrivateState> emit) {
    final isValid = _validateEmail(event.email);

    if (isValid) {
      emit(EmailChangedState(event.email));
    } else {
      emit(PrivateFailure('Email tidak valid'));
    }
  }

  void _onOldPasswordChange(
    OldPasswordChanged event,
    Emitter<PrivateState> emit,
  ) {
    if (event.oldPassword.isNotEmpty) {
      emit(OldPasswordChangedState(event.oldPassword));
    } else {
      emit(PrivateFailure('Kata sandi lama tidak boleh kosong'));
    }
  }

  void _onNewPasswordChange(
    NewPasswordChanged event,
    Emitter<PrivateState> emit,
  ) {
    final isValid = _validatePassword(event.newPassword);

    if (isValid) {
      emit(NewPasswordChangedState(event.newPassword));
    } else {
      emit(PrivateFailure(
          'Kata sandi baru harus memiliki setidaknya 8 karakter'));
    }
  }

  void _onConfirmPasswordChange(
    ConfirmPasswordChanged event,
    Emitter<PrivateState> emit,
  ) {
    final isValid = event.confirmPassword.isNotEmpty;

    if (isValid) {
      emit(ConfirmPasswordChangedState(event.confirmPassword));
    } else {
      emit(PrivateFailure('Konfirmasi kata sandi tidak boleh kosong'));
    }
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.length >= 8;
  }
}
