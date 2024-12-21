// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) =>
    AttachmentModel(
      fileName: json['file_name'] as String,
      fileType: json['file_type'] as String,
      fileUrl: json['file_url'] as String,
      resourceType: json['resource_type'] as String,
    );

Map<String, dynamic> _$AttachmentModelToJson(AttachmentModel instance) =>
    <String, dynamic>{
      'file_name': instance.fileName,
      'file_type': instance.fileType,
      'file_url': instance.fileUrl,
      'resource_type': instance.resourceType,
    };
