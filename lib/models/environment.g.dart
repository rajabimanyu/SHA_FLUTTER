// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnvironmentAdapter extends TypeAdapter<Environment> {
  @override
  final int typeId = 0;

  @override
  Environment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Environment(
      uuid: fields[0] as String,
      name: fields[1] as String,
      isCurrentEnvironment: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Environment obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isCurrentEnvironment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvironmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
