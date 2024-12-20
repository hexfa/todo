import 'package:json_annotation/json_annotation.dart';
import 'package:todo/domain/entities/due.dart';

part 'due_model.g.dart';

@JsonSerializable()
class DueModel extends Due {
  //start task
  String date;
  @JsonKey(name: 'is_recurring')
  final bool isRrecurring;

  //stop task
  String datetime;

  //start update_task
  String startTimer;
  final String timezone;

  DueModel({
    required this.date,
    required this.isRrecurring,
    required this.datetime,
    required this.startTimer,
    required this.timezone,
  }) : super(
          date: date,
          isRecurring: isRrecurring,
          datetime: datetime,
          startTimer: startTimer,
          timezone: timezone,
        );

  factory DueModel.fromJson(Map<String, dynamic> json) {
    print("DueModel |$json['due']['date']");
    return DueModel(
      date: json['due']['date'] as String,
      isRrecurring: json['due']['is_recurring'] as bool,
      datetime: json['due']['datetime'] as String,
      startTimer: json['due']['string'] as String,
      timezone: json['due']['timezone'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() => _$DueModelToJson(this);
}
