import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mesran_app/src/features/authentication/data/repository/verification_repository_impl.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/verification_request.dart';
import 'package:mesran_app/src/features/authentication/domain/failures/auth_failure.dart';

class VerificationUseCase {
  final FlutterSecureStorage _secureStorage;
  final int defaultVerificationKeyTimestamp = (5 * 60 * 1000);
  final VerificationRepositoryImpl _verificationRepositoryImpl;

  VerificationUseCase(this._verificationRepositoryImpl, this._secureStorage);

  Future<Either<Either<AuthFailure, Null>, bool>> verify(String otp) async {
    try {
      final verificationKeyTimestamp =
          await _secureStorage.read(key: 'verificationKeyTimestamp');

      if (verificationKeyTimestamp == null) {
        return Left(Right(null));
      }

      final timestamp = int.parse(verificationKeyTimestamp);
      final currentTime = DateTime.now().millisecondsSinceEpoch;

      if (currentTime - timestamp > defaultVerificationKeyTimestamp) {
        await _secureStorage.delete(key: 'verificationKey');
        await _secureStorage.delete(key: 'verificationKeyTimestamp');
        return Left(Right(null));
      }

      final verificationKey =
          await _secureStorage.read(key: 'verificationKey') as String;

      final response = await _verificationRepositoryImpl.verify(
          VerificationRequest(verificationKey: verificationKey, otp: otp));

      response.fold(
        (error) => Left(Left(error)),
        (success) {
          _secureStorage.deleteAll();

          final accessToken = success.data?.accessToken;
          final refreshToken = success.data?.refreshToken;

          if (accessToken != null && refreshToken != null) {
            _secureStorage.write(key: 'accessToken', value: accessToken);
            _secureStorage.write(key: 'refreshToken', value: refreshToken);

            return Right(true);
          }

          return Left(null);
        },
      );

      return Right(true);
    } catch (error) {
      return Left(Right(null));
    }
  }

  Future<bool> validateFace() async {
    return await _verificationRepositoryImpl.validateRegisteredFace();
  }
}
