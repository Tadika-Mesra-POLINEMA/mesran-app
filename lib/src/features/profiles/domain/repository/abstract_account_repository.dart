import 'package:mesran_app/src/features/profiles/domain/entity/account_request.dart';

abstract class AbstractAccountRepository {
  Future<bool> updateAccount(AccountRequest request);
}
