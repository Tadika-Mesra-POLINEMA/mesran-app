import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:mesran_app/src/core/api/ml_client.dart';
import 'package:mesran_app/src/features/users/domain/usecases/register_face_use_case.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_face_event.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_face_state.dart';

class RegisterFaceBloc extends Bloc<RegisterFaceEvent, RegisterFaceState> {
  final ML _mlClient;
  final RegisterFaceUseCase _registerFaceUseCase;

  RegisterFaceBloc(this._mlClient, this._registerFaceUseCase)
      : super(RegisterFaceState()) {
    on<CaptureFace>(_onCaptureFace);
  }

  void _onCaptureFace(
    CaptureFace event,
    Emitter<RegisterFaceState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

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
            _registerFaceUseCase.call(paths);

            emit(RegisterFaceSuccess());
          } catch (error) {
            emit(state.copyWith(
              hasError: true,
              isLoading: false,
              errorMessage: 'Failed to capture face: $error',
            ));
          }

          return;
        }

        emit(state.copyWith(
          paths: paths,
          capturedCount: paths.length,
          hasError: false,
          isLoading: false,
          errorMessage: null,
        ));
      } else {
        emit(state.copyWith(
          hasError: true,
          isLoading: false,
          errorMessage: 'Server responded with status: ${response.statusCode}',
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        hasError: true,
        isLoading: false,
        errorMessage: 'Failed to capture face: $error',
      ));
    }
  }
}
