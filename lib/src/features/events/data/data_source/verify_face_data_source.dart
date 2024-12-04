import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/events/domain/entities/res/verify_face_response.dart';
import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class VerifyFaceDataSource {
  final DioClient _dioClient;

  VerifyFaceDataSource(this._dioClient);

  Future<Either<Null, BaseResponse<VerifyFaceResponse>>> verifyFace(
      String path) async {
    try {
      final formData = FormData.fromMap({
        'face': await MultipartFile.fromFile(path),
      });

      final response = await _dioClient.client
          .post('/api/events/verify-face', data: formData);

      if (response.statusCode == 200) {
        return Right(
            BaseResponse.fromJson(response.data, VerifyFaceResponse.fromJson));
      } else {
        return Left(null);
      }
    } on DioException {
      return Left(null);
    } catch (error) {
      return Left(null);
    }
  }
}
