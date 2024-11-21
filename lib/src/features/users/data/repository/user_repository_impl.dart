import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/features/users/data/data_source/user_data_source.dart';
import 'package:mesran_app/src/features/users/domain/entity/register_request.dart';
import 'package:mesran_app/src/features/users/domain/repository/abstract_user_repository.dart';

class UserRepositoryImpl extends AbstractUserRepository {
  final UserDataSource _userDataSource;

  UserRepositoryImpl(this._userDataSource);

  @override
  Future<Either<Null, bool>> register(RegisterRequest request) async {
    try {
      final response = await _userDataSource.register(request);

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
}
