import 'package:mesran_app/src/features/events/domain/entities/participant.dart';
import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class Attendance extends JsonParseable {
  final List<Participant> attends;
  final List<Participant> notYetAttends;

  Attendance({required this.attends, required this.notYetAttends});

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      attends: (json['attends'] as List)
          .map((e) => Participant.fromJson(e))
          .toList(),
      notYetAttends: (json['not_yet_attends'] as List)
          .map((e) => Participant.fromJson(e))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'attends': attends.map((e) => e.toJson()).toList(),
      'not_yet_attends': notYetAttends.map((e) => e.toJson()).toList(),
    };
  }
}
