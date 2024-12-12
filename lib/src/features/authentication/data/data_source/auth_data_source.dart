import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/auth_request.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/auth_response.dart';
import 'package:mesran_app/src/features/authentication/domain/failures/auth_failure.dart';
import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class AuthDataSource {
  final DioClient _dioClient;

  AuthDataSource(this._dioClient);

  Future<Either<AuthFailure, BaseResponse<AuthResponse>>> login(
      AuthRequest request) async {
    try {
      final response = await _dioClient.post('/api/authentications', data: {
        'email': request.email,
        'password': request.password,
      });

      if (response.statusCode == 200) {
        return Right(
            BaseResponse.fromJson(response.data, AuthResponse.fromJson));
      } else {
        return Left(AuthFailure.fromJson(response.data));
      }
    } on DioException {
      return Left(AuthFailure(AuthStatusType.fail,
          message: 'Gagal login, silahkan coba lagi'));
    } catch (error) {
      return Left(AuthFailure(AuthStatusType.fail,
          message: 'Gagal login, silahkan coba lagi'));
    }
  }
}
