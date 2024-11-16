import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/authentication/data/data_source/verification_data_source.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/verification_request.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/verification_response.dart';
import 'package:mesran_app/src/features/authentication/domain/failures/auth_failure.dart';
import 'package:mesran_app/src/features/authentication/domain/repository/abstract_verification_repository.dart';
import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class VerificationRepositoryImpl extends AbstractVerificationRepository {
  final VerificationDataSource _verificationDataSource;

  VerificationRepositoryImpl(this._verificationDataSource);

  @override
  Future<Either<AuthFailure, BaseResponse<VerificationResponse>>> verify(
      VerificationRequest request) async {
    try {
      final response = await _verificationDataSource.verifyLogin(request);

      return response.fold(
        (error) {
          return Left(AuthFailure(AuthStatusType.fail, message: error.message));
        },
        (success) {
          return Right(success);
        },
      );
    } catch (error) {
      return Left(AuthFailure(AuthStatusType.fail, message: error.toString()));
    }
  }
}
