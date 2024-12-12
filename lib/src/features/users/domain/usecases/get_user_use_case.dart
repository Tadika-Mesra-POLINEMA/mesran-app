import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/users/data/repository/user_repository_impl.dart';
import 'package:mesran_app/src/features/users/domain/entity/get_user_response.dart';

class GetUserUseCase {
  final UserRepositoryImpl _userRepository;

  GetUserUseCase(this._userRepository);

  Future<Either<Null, GetUserResponse>> call() async {
    return await _userRepository.getUser();
  }
}
