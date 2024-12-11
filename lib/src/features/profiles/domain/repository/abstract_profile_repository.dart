import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/profiles/domain/entity/user.dart';

abstract class AbstractProfileRepository {
  Future<Either<Null, User>> getProfile();
}
