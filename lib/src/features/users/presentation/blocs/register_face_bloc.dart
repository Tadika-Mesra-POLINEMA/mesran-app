import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/core/api/ml_client.dart';
import 'package:mesran_app/src/features/users/domain/usecases/get_user_use_case.dart';
import 'package:mesran_app/src/features/users/domain/usecases/register_face_use_case.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_face_event.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_face_state.dart';

class RegisterFaceBloc extends Bloc<RegisterFaceEvent, RegisterFaceState> {
  final ML _mlClient;
  final RegisterFaceUseCase _registerFaceUseCase;
  final GetUserUseCase _getUserUseCase;

  RegisterFaceBloc(
      this._mlClient, this._registerFaceUseCase, this._getUserUseCase)
      : super(RegisterFaceState()) {
    on<CaptureFace>(_onCaptureFace);
    on<LoadUser>(_onLoadUser);
  }

  void _onCaptureFace(
    CaptureFace event,
    Emitter<RegisterFaceState> emit,
  ) async {
    emit(RegisterFaceLoading(
      capturedCount: state.capturedCount,
      paths: state.paths,
      user: state.user,
    ));

    final path = event.path;

    try {
      final response = await _mlClient.client.post(
        '/faces/validate',
        data: FormData.fromMap({
          'faces': await MultipartFile.fromFile(path),
        }),
      );

      if (response.statusCode == 200) {
        final paths = [...state.paths, path];

        if (paths.length == 5) {
          try {
            emit(VerifyingFace(
              capturedCount: paths.length,
              paths: paths,
              user: state.user,
            ));

            final registerFaceResponse = await _registerFaceUseCase.call(paths);

            registerFaceResponse.fold((_) {
              emit(RegisterFaceFailure(
                  'Gagal mendaftarkan wajah Anda, silakan coba lagi'));
            }, (_) {
              emit(RegisterFaceSuccess());
            });
          } catch (error) {
            emit(RegisterFaceFailure(
                'Gagal mendaftarkan wajah Anda, silakan coba lagi'));
          }

          return;
        }

        emit(state.copyWith(
          paths: paths,
          capturedCount: paths.length,
        ));
      } else {
        emit(VerifyFaceFailed(
          capturedCount: state.capturedCount,
          paths: state.paths,
          user: state.user,
          message: 'Wajah Anda tidak terdeteksi, silakan coba lagi',
        ));
      }
    } catch (error) {
      emit(VerifyFaceFailed(
        capturedCount: state.capturedCount,
        paths: state.paths,
        user: state.user,
        message: 'Wajah Anda tidak terdeteksi, silakan coba lagi',
      ));
    }
  }

  void _onLoadUser(
    LoadUser event,
    Emitter<RegisterFaceState> emit,
  ) async {
    emit(RegisterFaceLoading(
      capturedCount: state.capturedCount,
      paths: state.paths,
      user: state.user,
    ));
    try {
      final response = await _getUserUseCase.call();

      response.fold((_) {
        emit(RegisterFaceFailure('Gagal memuat data, silahkan coba lagi'));
      }, (user) {
        emit(state.copyWith(user: user));
      });
    } catch (error) {
      emit(RegisterFaceFailure('Gagal memuat data, silahkan coba lagi'));
    }
  }
}
