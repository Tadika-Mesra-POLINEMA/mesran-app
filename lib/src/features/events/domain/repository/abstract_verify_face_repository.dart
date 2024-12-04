import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/domain/entities/res/verify_face_response.dart';
import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

abstract class AbstractVerifyFaceRepository {
  Future<Either<Null, BaseResponse<VerifyFaceResponse>>> verifyFace(
      String path);
}
