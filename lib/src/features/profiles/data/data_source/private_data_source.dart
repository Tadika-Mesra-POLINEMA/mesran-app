import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/profiles/domain/entity/private_request.dart';

class  PrivateDataSource {
  final DioClient dioClient;

  PrivateDataSource(this.dioClient);

  Future<bool> updatePrivate(PrivateRequest request) async {
    try {
      final response = await dioClient.client.put(
        '/api/users',
        data: request.toJson(),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}