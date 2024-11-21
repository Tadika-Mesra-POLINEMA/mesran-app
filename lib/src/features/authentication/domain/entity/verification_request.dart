class VerificationRequest {
  final String verificationKey;
  final String otp;

  VerificationRequest({
    required this.verificationKey,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'verificationKey': verificationKey,
      'otp': otp,
    };
  }
}
