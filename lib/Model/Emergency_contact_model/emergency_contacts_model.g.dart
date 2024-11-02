// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_contacts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmergencyContactsModelAdapter
    extends TypeAdapter<EmergencyContactsModel> {
  @override
  final int typeId = 1;

  @override
  EmergencyContactsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmergencyContactsModel(
      contactType: fields[0] as String?,
      telecom: fields[1] as String?,
      number: fields[2] as String?,
      contactName: fields[3] as String?,
      url: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EmergencyContactsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.contactType)
      ..writeByte(1)
      ..write(obj.telecom)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.contactName)
      ..writeByte(4)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyContactsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
