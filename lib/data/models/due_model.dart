import 'package:json_annotation/json_annotation.dart';
import 'package:todo/domain/entities/due.dart';

part 'due_model.g.dart';

@JsonSerializable()
class DueModel extends Due {
  //deadline
  final String date;
  @JsonKey(name: 'is_recurring')
  final bool isRrecurring;

  //start timer
  final String datetime;
  @JsonKey(name: 'string')
  final String string;
  final String timezone;

  const DueModel({
    required this.date,
    required this.isRrecurring,
    required this.datetime,
    required this.string,
    required this.timezone,
  }) : super(
          date: date,
          isRecurring: isRrecurring,
          datetime: datetime,
          string: string,
          timezone: timezone,
        );

  factory DueModel.fromJson(Map<String, dynamic> json) {
    print("DueModel |$json['due']['date']");
    return DueModel(
      date: json['due']['date'] as String,
      isRrecurring: json['due']['is_recurring'] as bool,
      datetime: json['due']['datetime'] as String,
      string: json['due']['string'] as String,
      timezone: json['due']['timezone'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() => _$DueModelToJson(this);
}
