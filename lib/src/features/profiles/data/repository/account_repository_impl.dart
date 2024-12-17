import 'package:mesran_app/src/features/profiles/data/data_source/account_data_source.dart';
import 'package:mesran_app/src/features/profiles/domain/entity/account_request.dart';
import 'package:mesran_app/src/features/profiles/domain/repository/abstract_account_repository.dart';

class AccountRepositoryImpl extends AbstractAccountRepository{

  final AccountDataSource _accountDataSource;

  AccountRepositoryImpl(this._accountDataSource);
  @override
  Future<bool> updateAccount(AccountRequest request) async {
    return await _accountDataSource.updateAccount(request);
  }

}