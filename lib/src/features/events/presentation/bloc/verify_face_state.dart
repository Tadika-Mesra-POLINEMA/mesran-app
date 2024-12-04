import 'package:equatable/equatable.dart';

class VerifyFaceState extends Equatable {
  final String path;
  final bool hasError;
  final bool isLoading;
  final String? errorMessage;

  const VerifyFaceState({
    this.path = '',
    this.hasError = false,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        path,
        hasError,
        isLoading,
        errorMessage ?? '',
      ];

  VerifyFaceState copyWith({
    String? path,
    bool? hasError,
    bool? isLoading,
    String? errorMessage,
  }) {
    return VerifyFaceState(
      path: path ?? this.path,
      hasError: hasError ?? this.hasError,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class VerifyFaceSuccess extends VerifyFaceState {}

class VerifyFaceFailure extends VerifyFaceState {
  const VerifyFaceFailure({required String errorMessage})
      : super(hasError: true, errorMessage: errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
