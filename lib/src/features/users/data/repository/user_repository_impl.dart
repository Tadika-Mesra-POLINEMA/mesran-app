import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mesran_app/src/features/users/data/data_source/user_data_source.dart';
import 'package:mesran_app/src/features/users/domain/entity/get_user_response.dart';
import 'package:mesran_app/src/features/users/domain/entity/register_request.dart';
import 'package:mesran_app/src/features/users/domain/entity/register_response.dart';
import 'package:mesran_app/src/features/users/domain/repository/abstract_user_repository.dart';
import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class UserRepositoryImpl extends AbstractUserRepository {
  final UserDataSource _userDataSource;

  UserRepositoryImpl(this._userDataSource);

  @override
  Future<Either<Null, BaseResponse<RegisterResponse>>> register(
      RegisterRequest request) async {
    try {
      final response = await _userDataSource.register(request);

      debugPrint('IMPLEMENTATION: $response');

      return response.fold(
        (error) => Left(null),
        (successResponse) => Right(successResponse),
      );
    } on DioException {
      return Left(null);
    } catch (e) {
      return Left(null);
    }
  }

  @override
  Future<Either<Null, bool>> registerFaces(List<String> paths) async {
    try {
      final response = await _userDataSource.registerFaces(paths);

      return response.fold(
        (error) => Left(null),
        (successResponse) => Right(true),
      );
    } on DioException {
      return Left(null);
    } catch (e) {
      return Left(null);
    }
  }

  @override
  Future<Either<Null, GetUserResponse>> getUser() async {
    return await _userDataSource.getUser();
  }
}
