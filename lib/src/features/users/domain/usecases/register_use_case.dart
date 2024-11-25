import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mesran_app/src/features/users/data/repository/user_repository_impl.dart';
import 'package:mesran_app/src/features/users/domain/entity/register_request.dart';

class RegisterUseCase {
  final UserRepositoryImpl _userRepository;
  final FlutterSecureStorage _secureStorage;

  RegisterUseCase(this._userRepository, this._secureStorage);

  Future<Either<Null, bool>> call(RegisterRequest request) async {
    final response = await _userRepository.register(request);

    debugPrint('Response: $response');

    return response.fold(
      (error) => Left(null),
      (successResponse) async {
        final accessToken = successResponse.data?.accessToken;
        if (accessToken != null && accessToken.isNotEmpty) {
          await _secureStorage.write(key: 'accessToken', value: accessToken);
          final savedToken = await _secureStorage.read(key: 'accessToken');
          debugPrint('AccessToken dari secure storage: $savedToken');
          debugPrint('AccessToken berhasil disimpan: $accessToken');
        } else {
          debugPrint('AccessToken tidak valid: $accessToken');
        }

        final refreshToken = successResponse.data?.refreshToken;
        if (refreshToken != null && refreshToken.isNotEmpty) {
          await _secureStorage.write(key: 'refreshToken', value: refreshToken);
          debugPrint('RefreshToken berhasil disimpan: $refreshToken');
        } else {
          debugPrint('RefreshToken tidak valid: $refreshToken');
        }

        return Right(true);
      },
    );
  }
}
