import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/verification_request.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/verification_response.dart';
import 'package:mesran_app/src/features/authentication/domain/failures/auth_failure.dart';
import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

abstract class AbstractVerificationRepository {
  Future<Either<AuthFailure, BaseResponse<VerificationResponse>>> verify(
      VerificationRequest request);
  Future<bool> validateRegisteredFace();
}
