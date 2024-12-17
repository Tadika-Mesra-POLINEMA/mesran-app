import 'package:mesran_app/src/features/profiles/data/repository/account_repository_impl.dart';
import 'package:mesran_app/src/features/profiles/domain/entity/account_request.dart';

class UpdateAccountUseCase {
  final AccountRepositoryImpl _accountRepositoryImpl;

  UpdateAccountUseCase(this._accountRepositoryImpl);

  Future<bool> call(AccountRequest request) async {
    return await _accountRepositoryImpl.updateAccount(request);
  }
}
