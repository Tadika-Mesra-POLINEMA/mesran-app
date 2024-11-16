abstract class JsonParseable {
  Map<String, dynamic> toJson();
}

class BaseResponse<T extends JsonParseable> {
  final T? data;
  final String message;
  final StatusType status;

  BaseResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    StatusType statusType = StatusType.values.firstWhere(
      (e) => e.toString().split('.').last == json['status'],
      orElse: () => StatusType.error,
    );

    T? parsedData;
    if (json['data'] != null) {
      parsedData = fromJson(json['data'] as Map<String, dynamic>);
    }

    return BaseResponse<T>(
      status: statusType,
      message: json['message'] ?? '',
      data: parsedData,
    );
  }
}

enum StatusType {
  success,
  error,
  warning,
}
