// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surrounding.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurroundingAdapter extends TypeAdapter<Surrounding> {
  @override
  final int typeId = 1;

  @override
  Surrounding read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Surrounding(
      uuid: fields[0] as String,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Surrounding obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurroundingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
