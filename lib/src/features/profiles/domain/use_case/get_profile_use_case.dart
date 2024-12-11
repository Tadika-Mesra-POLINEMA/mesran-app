import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/profiles/data/repository/profile_repository_impl.dart';
import 'package:mesran_app/src/features/profiles/domain/entity/user.dart';

class GetProfileUseCase {
  final ProfileRepositoryImpl _profileRepositoryImpl;

  GetProfileUseCase(this._profileRepositoryImpl);
  Future<Either<Null, User>> call() async {
    return await _profileRepositoryImpl.getProfile();
  }
}
