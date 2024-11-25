import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/users/domain/entity/register_request.dart';
import 'package:mesran_app/src/features/users/domain/entity/register_response.dart';
import 'package:mesran_app/src/shared/domain/entities/base_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataSource {
  final DioClient _dio;
  final SharedPreferences _sharedPreferences;

  UserDataSource(this._dio, this._sharedPreferences);

  Future<Either<Null, BaseResponse<RegisterResponse>>> register(
      RegisterRequest request) async {
    try {
      final response = await _dio.post('/api/users', data: request.toJson());

      if (response.statusCode == 201) {
        return Right(
            BaseResponse.fromJson(response.data, RegisterResponse.fromJson));
      } else {
        return Left(null);
      }
    } on DioException {
      return Left(null);
    } catch (error) {
      return Left(null);
    }
  }

  Future<Either<Null, BaseResponse>> registerFaces(List<String> paths) async {
    try {
      final formData = FormData.fromMap({
        'faces': paths
            .map((path) => MultipartFile.fromFileSync(path))
            .toList(growable: false)
      });

      final response =
          await _dio.client.post('/api/users/faces', data: formData);

      if (response.statusCode == 200) {
        _sharedPreferences.setBool('is_registered_face', true);

        return Right(
            BaseResponse.fromJson(response.data, RegisterResponse.fromJson));
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
