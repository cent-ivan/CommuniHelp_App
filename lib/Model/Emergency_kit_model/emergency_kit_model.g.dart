// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_kit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmergencyKitModelAdapter extends TypeAdapter<EmergencyKitModel> {
  @override
  final int typeId = 0;

  @override
  EmergencyKitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmergencyKitModel(
      title: fields[0] as String?,
      isChecked: fields[1] as bool?,
      imagePath: fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, EmergencyKitModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.isChecked)
      ..writeByte(2)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyKitModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
