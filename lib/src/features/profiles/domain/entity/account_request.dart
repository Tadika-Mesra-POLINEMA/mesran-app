class AccountRequest {
  final String? name;
  final String? phone;

  AccountRequest({
    this.name,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
    };
  }
}
