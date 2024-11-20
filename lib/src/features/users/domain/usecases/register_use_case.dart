import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/users/data/repository/user_repository_impl.dart';
import 'package:mesran_app/src/features/users/domain/entity/register_request.dart';

class RegisterUseCase {
  final UserRepositoryImpl _userRepository;

  RegisterUseCase(this._userRepository);

  Future<Either<Null, bool>> call(RegisterRequest request) async {
    return await _userRepository.register(request);
  }
}
