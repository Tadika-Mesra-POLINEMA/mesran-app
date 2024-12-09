import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/data/repository/verify_face_repository_impl.dart';
import 'package:mesran_app/src/features/events/domain/entities/res/verify_face_response.dart';
import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class VerifyFaceUseCase {
  final VerifyFaceRepositoryImpl _verifyFaceRepositoryImpl;

  VerifyFaceUseCase(this._verifyFaceRepositoryImpl);

  Future<Either<bool, VerifyFaceResponse>> call(String path) async {
    final response = await _verifyFaceRepositoryImpl.verifyFace(path);

    return response.fold(
      (error) => left(false),
      (successResponse) => right(successResponse),
    );
  }
}
