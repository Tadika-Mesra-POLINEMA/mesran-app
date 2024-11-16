import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mesran_app/src/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:mesran_app/src/features/authentication/domain/entity/auth_request.dart';
import 'package:mesran_app/src/features/authentication/domain/failures/auth_failure.dart';

class AuthUseCase {
  final AuthRepositoryImpl _authRepositoryImpl;
  final FlutterSecureStorage _secureStorage;
  final int defaultVerificationKeyTimestamp = (5 * 60 * 1000);

  AuthUseCase(this._authRepositoryImpl, this._secureStorage);

  Future<Either<AuthFailure, void>> login(AuthRequest request) async {
    try {
      final response = await _authRepositoryImpl.authenticate(request);

      return response.fold(
        (error) {
          return Left(AuthFailure(AuthStatusType.fail, message: error.message));
        },
        (success) async {
          final verificationKey = success.data?.verificationKey;

          if (verificationKey == null) {
            return Left(AuthFailure(AuthStatusType.fail,
                message: 'Verification key tidak ditemukan'));
          }

          try {
            await _secureStorage.write(
                key: 'verificationKey', value: verificationKey);
            await _secureStorage.write(
                key: 'verificationKeyTimestamp',
                value: DateTime.now().millisecondsSinceEpoch.toString());
          } catch (storageError) {
            return Left(AuthFailure(AuthStatusType.fail,
                message: 'Gagal menyimpan verification key'));
          }
          return const Right(null);
        },
      );
    } on DioException catch (dioError) {
      return Left(AuthFailure(AuthStatusType.fail,
          message: 'Kesalahan koneksi API: ${dioError.message}'));
    } catch (error) {
      return Left(AuthFailure(AuthStatusType.fail,
          message: 'Terjadi kesalahan yang tidak diketahui'));
    }
  }
}
