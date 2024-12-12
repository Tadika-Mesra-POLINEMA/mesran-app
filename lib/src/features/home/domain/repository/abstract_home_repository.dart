import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/home/domain/entity/event.dart';
import 'package:mesran_app/src/features/home/domain/entity/user.dart';

abstract class AbstractHomeRepository {
  Future<Either<Null, List<EventHome>>> getHomeData();
  Future<Either<Null, User>> getUserProfile();
}
