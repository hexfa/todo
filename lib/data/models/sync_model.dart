import 'package:hive_flutter/hive_flutter.dart';

part 'sync_model.g.dart';

@HiveType(typeId: 2)
class SyncOperation extends HiveObject {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final Map<String, dynamic>? data;

  @HiveField(3)
  final String entityType;

  SyncOperation({
    required this.type,
    required this.id,
    this.data,
    required this.entityType,
  });
}
