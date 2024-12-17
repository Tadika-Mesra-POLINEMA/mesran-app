import 'package:mesran_app/src/features/profiles/domain/entity/private_request.dart';

abstract class AbstractPrivateRepository {
  Future<bool> updatePrivate(PrivateRequest request);
}
