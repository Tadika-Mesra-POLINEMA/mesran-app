import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/users/domain/entity/register_request.dart';

abstract class AbstractUserRepository {
  Future<Either<Null, bool>> register(RegisterRequest request);
}
