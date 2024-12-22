import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'duration_model.g.dart';

@HiveType(typeId: 3) // Set a unique typeId for Hive
@JsonSerializable()
class DurationModel extends HiveObject {
  @HiveField(0)
  int amount;

  @HiveField(1)
  final String unit;

  DurationModel({
    required this.amount,
    required this.unit,
  });

  factory DurationModel.fromJson(Map<String, dynamic> json) {
    return DurationModel(
      amount: json['amount'] as int,
      unit: json['unit'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$DurationModelToJson(this);

  String toEntity() {
    return '$amount $unit';
  }
}
