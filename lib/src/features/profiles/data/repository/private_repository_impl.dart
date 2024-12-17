import 'package:mesran_app/src/features/profiles/data/data_source/private_data_source.dart';
import 'package:mesran_app/src/features/profiles/domain/entity/private_request.dart';
import 'package:mesran_app/src/features/profiles/domain/repository/abstract_private_repository.dart';

class PrivateRepositoryImpl implements AbstractPrivateRepository {
  final PrivateDataSource _privateDataSource;

  PrivateRepositoryImpl(this._privateDataSource);

  @override
  Future<bool> updatePrivate(PrivateRequest request) async {
    return await _privateDataSource.updatePrivate(request);
  }
}