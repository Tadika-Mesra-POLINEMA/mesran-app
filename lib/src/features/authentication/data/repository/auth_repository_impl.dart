import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/features/authentication/data/data_source/auth_data_source.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/auth_request.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/auth_response.dart';
import 'package:mesran_app/src/features/authentication/domain/failures/auth_failure.dart';
import 'package:mesran_app/src/features/authentication/domain/repository/abstract_auth_repository.dart';
import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class AuthRepositoryImpl extends AbstractAuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<Either<AuthFailure, BaseResponse<AuthResponse>>> authenticate(
      AuthRequest request) async {
    try {
      final response = await _authDataSource.login(request);

      print(response);

      return response.fold(
        (error) =>
            Left(AuthFailure(AuthStatusType.fail, message: error.message)),
        (successResponse) => Right(successResponse),
      );
    } on DioException catch (error) {
      return Left(AuthFailure(AuthStatusType.fail, message: error.toString()));
    } catch (e) {
      return Left(
          AuthFailure(AuthStatusType.fail, message: 'Terjadi kesalahan'));
    }
  }
}
