import 'package:mesran_app/src/shared/domain/entities/base_response.dart';

class HistoryEvent extends JsonParseable {
  final String id;
  final String name;
  final DateTime date;
  final String description;

  HistoryEvent({
    required this.id,
    required this.name,
    required this.date,
    required this.description,
  });

  List<Object> get props => [id, name, date, description];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'target_date': date,
      'description': description,
    };
  }

  factory HistoryEvent.fromJson(Map<String, dynamic> json) {
    return HistoryEvent(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['target_date']),
      description: json['description'],
    );
  }
}
