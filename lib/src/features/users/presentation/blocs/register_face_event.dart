import 'package:equatable/equatable.dart';

class RegisterFaceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CaptureFace extends RegisterFaceEvent {
  final String path;

  CaptureFace(this.path);

  @override
  List<Object?> get props => [path];
}
