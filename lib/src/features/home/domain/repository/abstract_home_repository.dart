import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/home/domain/entity/event.dart';

abstract class AbstractHomeRepository {
  Future<Either<Null, List<EventHome>>> getHomeData();
}
