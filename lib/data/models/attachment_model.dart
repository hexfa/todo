import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/attachment.dart';

part 'attachment_model.g.dart';

@HiveType(typeId: 6) // Set a unique typeId for Hive
@JsonSerializable()
class AttachmentModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'file_name')
  final String fileName;

  @HiveField(1)
  @JsonKey(name: 'file_type')
  final String fileType;

  @HiveField(2)
  @JsonKey(name: 'file_url')
  final String fileUrl;

  @HiveField(3)
  @JsonKey(name: 'resource_type')
  final String resourceType;

  AttachmentModel({
    required this.fileName,
    required this.fileType,
    required this.fileUrl,
    required this.resourceType,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);

  Attachment toEntity() {
    return Attachment(
      fileName: fileName,
      fileType: fileType,
      fileUrl: fileUrl,
      resourceType: resourceType,
    );
  }
}
