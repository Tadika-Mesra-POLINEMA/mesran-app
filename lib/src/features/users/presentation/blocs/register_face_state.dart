import 'package:equatable/equatable.dart';

class RegisterFaceState extends Equatable {
  final List<String> paths;
  final int capturedCount;
  final bool hasError;
  final String? errorMessage;

  const RegisterFaceState({
    this.paths = const [],
    this.capturedCount = 0,
    this.hasError = false,
    this.errorMessage,
  });

  RegisterFaceState copyWith({
    List<String>? paths,
    int? capturedCount,
    bool? hasError,
    String? errorMessage,
  }) {
    return RegisterFaceState(
      paths: paths ?? this.paths,
      capturedCount: capturedCount ?? this.capturedCount,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [paths, capturedCount, hasError, errorMessage ?? ''];
}

class CaptureFaceComplete extends RegisterFaceState {
  final int captureCount;

  const CaptureFaceComplete(this.captureCount);

  @override
  List<Object?> get props => [captureCount];
}

class RegisterFaceInitial extends RegisterFaceState {}

class RegisterFaceLoading extends RegisterFaceState {}

class RegisterFaceSuccess extends RegisterFaceState {}

class RegisterFaceFailure extends RegisterFaceState {
  final String message;

  const RegisterFaceFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
