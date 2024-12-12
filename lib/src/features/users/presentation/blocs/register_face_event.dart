import 'package:equatable/equatable.dart';

class RegisterFaceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CaptureFace extends RegisterFaceEvent {
  final String path;
  final int captureCount;

  CaptureFace(this.path, this.captureCount);

  @override
  List<Object?> get props => [path];
}

class LoadUser extends RegisterFaceEvent {}
