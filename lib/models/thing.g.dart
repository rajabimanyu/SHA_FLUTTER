// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thing.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThingAdapter extends TypeAdapter<Thing> {
  @override
  final int typeId = 3;

  @override
  Thing read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Thing(
      environmentID: fields[0] as String,
      deviceID: fields[1] as String,
      id: fields[2] as String,
      status: fields[4] as String,
      thingType: fields[3] as String,
      totalStep: fields[5] as int,
      currentStep: fields[6] as int,
      lastUpdatedTime: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Thing obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.environmentID)
      ..writeByte(1)
      ..write(obj.deviceID)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.thingType)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.totalStep)
      ..writeByte(6)
      ..write(obj.currentStep)
      ..writeByte(7)
      ..write(obj.lastUpdatedTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
