import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/users/domain/entity/register_request.dart';
import 'package:mesran_app/src/features/users/domain/entity/register_response.dart';
import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class UserDataSource {
  final DioClient _dio;

  UserDataSource(this._dio);

  Future<Either<Null, BaseResponse<RegisterResponse>>> register(
      RegisterRequest request) async {
    try {
      final response = await _dio.post('/api/users', data: request.toJson());

      if (response.statusCode == 200) {
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
