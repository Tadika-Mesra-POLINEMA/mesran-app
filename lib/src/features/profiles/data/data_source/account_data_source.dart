import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/profiles/domain/entity/account_request.dart';

class AccountDataSource {
  final DioClient _dioClient;

  AccountDataSource(this._dioClient);

  Future<bool> updateAccount(AccountRequest request) async {
    try {
      final response = await _dioClient.client
          .patch('/api/users/profile', 
          data: request.toJson());

      return response.statusCode == 200;
    } catch (error) {
      return false;
    }
  }
}
