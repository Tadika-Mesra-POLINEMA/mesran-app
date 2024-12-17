import 'package:bloc/bloc.dart';
import 'package:mesran_app/src/features/profiles/domain/entity/account_request.dart';
import 'package:mesran_app/src/features/profiles/domain/use_case/update_account_use_case.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/account_event.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UpdateAccountUseCase updateAccountUseCase;

  AccountBloc(
    this.updateAccountUseCase,
  ) : super(AccountInitial()) {
    on<UpdateAccount>(_onUpdateAccount);
    on<OnChangeName>(_onChangeName);
    on<OnPhoneChange>(_onPhoneChange);
  }

  Future<void> _onUpdateAccount(
    UpdateAccount event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());

    final response = await updateAccountUseCase
        .call(AccountRequest(name: event.name, phone: event.phone));
    if (response) {
      emit(AccountSuccess());
    } else {
      emit(AccountFailure('Update account gagal'));
    }
  }

  void _onChangeName(OnChangeName event, Emitter<AccountState> emit) {
    final isValid = _validateName(event.name);

    if (isValid) {
      emit(NameChanged(event.name));
    }
  }

  bool _validateName(String name) {
    return name.length > 3;
  }

  void _onPhoneChange(OnPhoneChange event, Emitter<AccountState> emit) {
    final isValid = _validatePhone(event.phone);

    if (isValid) {
      emit(PhoneChanged(event.phone));
    }
  }

  bool _validatePhone(String phone) {
    return phone.length > 10 && phone.length <= 13;
  }
}
