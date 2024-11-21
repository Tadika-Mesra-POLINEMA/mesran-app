import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/auth_request.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/auth_response.dart';
import 'package:mesran_app/src/features/authentication/domain/failures/auth_failure.dart';
import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

abstract class AbstractAuthRepository {
  Future<Either<AuthFailure, BaseResponse<AuthResponse>>> authenticate(
      AuthRequest request);
}
