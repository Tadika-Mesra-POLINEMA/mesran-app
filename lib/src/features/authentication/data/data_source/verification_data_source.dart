import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/verification_request.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/verification_response.dart';
import 'package:mesran_app/src/features/authentication/domain/failures/auth_failure.dart';
import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class VerificationDataSource {
  final DioClient _dioClient;

  VerificationDataSource(this._dioClient);

  Future<Either<AuthFailure, BaseResponse<VerificationResponse>>> verifyLogin(
      VerificationRequest request) async {
    try {
      final response = await _dioClient
          .post('/api/authentications/verify-login', data: request.toJson());

      if (response.statusCode == 200) {
        return Right(BaseResponse.fromJson(
            response.data, VerificationResponse.fromJson));
      } else {
        return Left(AuthFailure.fromJson(response.data));
      }
    } on DioException catch (error) {
      return Left(AuthFailure(AuthStatusType.fail, message: error.toString()));
    } catch (error) {
      return Left(AuthFailure(AuthStatusType.fail, message: error.toString()));
    }
  }
}
