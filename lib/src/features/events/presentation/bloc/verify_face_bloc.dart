import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/events/domain/use_case/verify_face_use_case.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/verify_face_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/verify_face_state.dart';

class VerifyFaceBloc extends Bloc<VerifyFaceEvent, VerifyFaceState> {
  final VerifyFaceUseCase _verifyFaceUseCase;

  VerifyFaceBloc(this._verifyFaceUseCase) : super(const VerifyFaceState()) {
    on<CaptureFace>(_onCaptureFace);
  }

  _onCaptureFace(
    CaptureFace event,
    Emitter<VerifyFaceState> emit,
  ) async {
    if (event.path.isNotEmpty) {
      emit(state.copyWith(isLoading: true));

      final response = await _verifyFaceUseCase.call(event.path);

      return response.fold(
        (error) {
          emit(VerifyFaceFailure(
            errorMessage: 'Wajah tidak terdeteksi',
          ));
        },
        (successResponse) {
          emit(VerifyFaceSuccess(response: successResponse));
        },
      );
    }
  }
}
