import 'package:mesran_app/src/core/api/dio_client.dart';

class InvitationDataSource {
  final DioClient _dioClient;

  InvitationDataSource(this._dioClient);

  Future<bool> acceptInvitation(String eventId, String userId) async {
    try {
      final response = await _dioClient
          .post('/api/events/$eventId/participants/$userId/accept');

      return response.statusCode != 200;
    } catch (error) {
      return false;
    }
  }

  Future<bool> declineInvitation(String eventId, String userId) async {
    try {
      final response = await _dioClient.client
          .delete('/api/events/$eventId/participants/$userId/decline');

      return response.statusCode != 200;
    } catch (error) {
      return false;
    }
  }
}
