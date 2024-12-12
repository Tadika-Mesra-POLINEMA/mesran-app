import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/home/data/repository/home_repository_impl.dart';
import 'package:mesran_app/src/features/home/domain/entity/user.dart';

class GetUserProfileUseCase {
  final HomeRepositoryImpl _homeRepositoryImpl;

  GetUserProfileUseCase(this._homeRepositoryImpl);

  Future<Either<Null, User>> call() async {
    return await _homeRepositoryImpl.getUserProfile();
  }
}
