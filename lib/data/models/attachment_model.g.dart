// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttachmentModelAdapter extends TypeAdapter<AttachmentModel> {
  @override
  final int typeId = 6;

  @override
  AttachmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttachmentModel(
      fileName: fields[0] as String,
      fileType: fields[1] as String,
      fileUrl: fields[2] as String,
      resourceType: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AttachmentModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.fileName)
      ..writeByte(1)
      ..write(obj.fileType)
      ..writeByte(2)
      ..write(obj.fileUrl)
      ..writeByte(3)
      ..write(obj.resourceType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttachmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
