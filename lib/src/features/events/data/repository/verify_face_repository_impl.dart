import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/features/events/data/data_source/verify_face_data_source.dart';
import 'package:mesran_app/src/features/events/domain/entities/res/verify_face_response.dart';
import 'package:mesran_app/src/features/events/domain/repository/abstract_verify_face_repository.dart';

class VerifyFaceRepositoryImpl extends AbstractVerifyFaceRepository {
  final VerifyFaceDataSource _verifyFaceDataSource;

  VerifyFaceRepositoryImpl(this._verifyFaceDataSource);

  @override
  Future<Either<Null, VerifyFaceResponse>> verifyFace(String path) async {
    try {
      final response = await _verifyFaceDataSource.verifyFace(path);

      return response.fold(
        (error) => Left(null),
        (successResponse) => Right(successResponse),
      );
    } on DioException {
      return Left(null);
    } catch (e) {
      return Left(null);
    }
  }
}
