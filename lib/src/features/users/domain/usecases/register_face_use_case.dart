import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/users/data/repository/user_repository_impl.dart';

class RegisterFaceUseCase {
  final UserRepositoryImpl _userRepositoryImpl;

  RegisterFaceUseCase(this._userRepositoryImpl);

  Future<Either<Null, bool>> call(List<String> paths) async {
    return await _userRepositoryImpl.registerFaces(paths);
  }
}
