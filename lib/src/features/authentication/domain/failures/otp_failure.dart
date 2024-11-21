class OtpFailure {
  final String message;

  OtpFailure(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OtpFailure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
