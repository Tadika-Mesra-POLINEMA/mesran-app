import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/home/data/data_source/home_data_source.dart';
import 'package:mesran_app/src/features/home/domain/entity/event.dart';
import 'package:mesran_app/src/features/home/domain/repository/abstract_home_repository.dart';

class HomeRepositoryImpl extends AbstractHomeRepository {
  final HomeDataSource _homeDataSource;

  HomeRepositoryImpl(this._homeDataSource);

  @override
  Future<Either<Null, List<EventHome>>> getHomeData() async {
    final response = await _homeDataSource.fetchEvents();

    return response.fold((errorResponse) {
      return Left(null);
    }, (successResponse) {
      return Right(successResponse);
    });
  }
}
