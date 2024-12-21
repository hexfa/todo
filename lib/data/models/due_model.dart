import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo/domain/entities/due.dart'; // فرض بر این است که کلاس Entity به نام Due تعریف شده باشد.

part 'due_model.g.dart';

@HiveType(typeId: 4) // Set a unique typeId for Hive
@JsonSerializable()
class DueModel extends HiveObject {
  @HiveField(0)
  final String? date;

  @HiveField(1)
  @JsonKey(name: 'is_recurring')
  final bool? isRecurring;

  @HiveField(2)
  final String? datetime;

  @HiveField(3)
  final String? string;

  @HiveField(4)
  final String? timezone;

  DueModel({
    required this.date,
    required this.isRecurring,
    required this.datetime,
    required this.string,
    required this.timezone,
  });

  factory DueModel.fromJson(Map<String, dynamic> json) {
    return DueModel(
      date: json['date'] as String?,
      isRecurring: json['is_recurring'] as bool?,
      datetime: json['datetime'] as String?,
      string: json['string'] as String?,
      timezone: json['timezone'] as String?,
    );
  }

  Map<String, dynamic> toJson() => _$DueModelToJson(this);

  Due toEntity() {
    return Due(
      date: date ?? '',
      isRecurring: isRecurring ?? false,
      datetime: datetime ?? '',
      string: string ?? '',
      timezone: timezone ?? '',
    );
  }
}
