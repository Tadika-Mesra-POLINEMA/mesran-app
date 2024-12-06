import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/home/data/repository/home_repository_impl.dart';
import 'package:mesran_app/src/features/home/domain/entity/event.dart';

class GetHomeEventsUseCase {
  final HomeRepositoryImpl repository;

  GetHomeEventsUseCase(this.repository);

  Future<Either<Null, List<EventHome>>> call() async {
    return await repository.getHomeData();
  }
}
