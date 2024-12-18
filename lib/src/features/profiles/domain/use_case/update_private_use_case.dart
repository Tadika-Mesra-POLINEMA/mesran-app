import 'package:mesran_app/src/features/profiles/data/repository/private_repository_impl.dart';
import 'package:mesran_app/src/features/profiles/domain/entity/private_request.dart';

class UpdatePrivateUseCase {
  final PrivateRepositoryImpl _privateRepositoryImpl;

  UpdatePrivateUseCase(this._privateRepositoryImpl);

  Future<bool> call(PrivateRequest request) async {
    return await _privateRepositoryImpl.updatePrivate(request);
  }
}
