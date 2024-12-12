import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/users/domain/entity/get_user_response.dart';
import 'package:mesran_app/src/features/users/domain/entity/register_request.dart';
import 'package:mesran_app/src/features/users/domain/entity/register_response.dart';
import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

abstract class AbstractUserRepository {
  Future<Either<Null, BaseResponse<RegisterResponse>>> register(
      RegisterRequest request);
  Future<Either<Null, bool>> registerFaces(List<String> paths);
  Future<Either<Null, GetUserResponse>> getUser();
}
