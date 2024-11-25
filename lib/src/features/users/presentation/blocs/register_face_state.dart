import 'package:equatable/equatable.dart';

class RegisterFaceState extends Equatable {
  final List<String> paths;
  final int capturedCount;
  final bool hasError;
  final bool isLoading;
  final String? errorMessage;

  const RegisterFaceState({
    this.paths = const [],
    this.capturedCount = 0,
    this.hasError = false,
    this.isLoading = false,
    this.errorMessage,
  });

  RegisterFaceState copyWith({
    List<String>? paths,
    int? capturedCount,
    bool? hasError,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RegisterFaceState(
      paths: paths ?? this.paths,
      capturedCount: capturedCount ?? this.capturedCount,
      hasError: hasError ?? this.hasError,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [paths, capturedCount, hasError, errorMessage ?? ''];
}

class RegisterFaceInitial extends RegisterFaceState {}

class RegisterFaceSuccess extends RegisterFaceState {}
