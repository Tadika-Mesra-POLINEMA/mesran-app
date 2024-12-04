import 'package:equatable/equatable.dart';

class VerifyFaceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerifyFaceInitial extends VerifyFaceEvent {}

class CaptureFace extends VerifyFaceEvent {
  final String path;

  CaptureFace(this.path);

  @override
  List<Object?> get props => [path];
}
