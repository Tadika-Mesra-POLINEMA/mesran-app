import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/core/api/ml_client.dart';
import 'package:mesran_app/src/features/users/domain/usecases/register_face_use_case.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_face_event.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_face_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterFaceBloc extends Bloc<RegisterFaceEvent, RegisterFaceState> {
  final ML _mlClient;
  final RegisterFaceUseCase _registerFaceUseCase;
  final SharedPreferences prefs;

  RegisterFaceBloc(this._mlClient, this._registerFaceUseCase, this.prefs)
      : super(RegisterFaceState(paths: const [])) {
    prefs.remove('facePaths');
    on<CaptureFace>(_onCaptureFace);
  }

  void _onCaptureFace(
    CaptureFace event,
    Emitter<RegisterFaceState> emit,
  ) async {
    emit(RegisterFaceLoading());
    final path = event.path;

    try {
      final response = await _mlClient.client.post(
        '/faces/validate',
        data: FormData.fromMap({
          'faces': await MultipartFile.fromFile(path),
        }),
      );

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        List<String> savedPaths = prefs.getStringList('facePaths') ?? [];

        if (savedPaths.length < 5) {
          savedPaths.add(path);
          await prefs.setStringList('facePaths', savedPaths);
        }

        if (savedPaths.length == 5) {
          emit(CaptureFaceComplete(savedPaths.length));

          try {
            await _registerFaceUseCase.call(savedPaths);

            await prefs.remove('facePaths');

            emit(RegisterFaceSuccess());
          } catch (error) {
            emit(RegisterFaceFailure(message: 'Gagal mendaftarkan wajah Anda'));
          }
          return;
        }

        emit(state.copyWith(
          paths: savedPaths,
          capturedCount: savedPaths.length,
          hasError: false,
          errorMessage: null,
        ));
        return;
      } else {
        emit(RegisterFaceFailure(
            message:
                'Gagal mengambil wajah, coba sesuaikan wajah Anda pada tempat yang telah disediakan'));
      }
    } catch (error) {
      emit(RegisterFaceFailure(
          message:
              'Gagal mengambil wajah, sesuaikan wajah Anda pada tempat yang disediakan'));
    }
  }
}
