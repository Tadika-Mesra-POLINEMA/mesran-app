import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/profiles/domain/entity/user.dart';

class ProfileDataSource {
  final DioClient _dioClient;

  ProfileDataSource(this._dioClient);

  Future<Either<Null, User>> fetchProfile() async {
    try {
      final response = await _dioClient.get('/api/users/me');

      if (response.statusCode == 200) {
        return Right(User.fromJson(response.data['data']));
      } else {
        return Left(null);
      }
    } catch (error) {
      return Left(null);
    }
  }
}
