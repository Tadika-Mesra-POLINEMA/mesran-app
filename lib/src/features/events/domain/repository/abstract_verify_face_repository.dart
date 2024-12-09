import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/domain/entities/res/verify_face_response.dart';

abstract class AbstractVerifyFaceRepository {
  Future<Either<Null, VerifyFaceResponse>> verifyFace(String path);
}
