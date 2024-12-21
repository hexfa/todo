import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/attachment.dart';

part 'attachment_model.g.dart';
@JsonSerializable()
class AttachmentModel extends Attachment {
  @JsonKey(name: 'file_name') final String fileName;
  @JsonKey(name: 'file_type') final String fileType;
  @JsonKey(name: 'file_url') final String fileUrl;
  @JsonKey(name: 'resource_type') final String resourceType;
  AttachmentModel({
    required this. fileName,
    required this. fileType,
    required this. fileUrl,
    required this. resourceType,
  }) : super(
          fileName: fileName,
          fileType: fileType,
          fileUrl: fileUrl,
          resourceType: resourceType,
        );

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);
}
