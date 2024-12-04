import 'package:flutter/material.dart';
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
  ) {
    if (event.path.isNotEmpty) {
      emit(state.copyWith(isLoading: true));
      debugPrint('Starting _verifyFaceUseCase with path: ${event.path}');

      _verifyFaceUseCase(event.path).then((response) {
        debugPrint('Received response from _verifyFaceUseCase');
        response.fold(
          (error) {
            debugPrint('Error occurred: $error');
            emit(VerifyFaceFailure(
              errorMessage: 'Failed to verify face: $error',
            ));
          },
          (successResponse) {
            debugPrint('Face verification succeeded: $successResponse');
            emit(VerifyFaceSuccess());
          },
        );
      }).catchError((e) {
        debugPrint('Unhandled exception: $e');
      });
    }
  }
}
