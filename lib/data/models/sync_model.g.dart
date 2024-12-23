// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SyncOperationAdapter extends TypeAdapter<SyncOperation> {
  @override
  final int typeId = 2;

  @override
  SyncOperation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SyncOperation(
      type: fields[0] as String,
      id: fields[1] as String,
      data: (fields[2] as Map?)?.cast<String, dynamic>(),
      entityType: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SyncOperation obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.entityType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncOperationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
