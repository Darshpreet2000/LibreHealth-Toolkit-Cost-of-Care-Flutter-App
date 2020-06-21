// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospitals.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HospitalsAdapter extends TypeAdapter<Hospitals> {
  @override
  final typeId = 0;

  @override
  Hospitals read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hospitals(
      fields[0] as String,
      fields[4] as Future,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Hospitals obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.distance)
      ..writeByte(2)
      ..write(obj.beds)
      ..writeByte(3)
      ..write(obj.operator)
      ..writeByte(4)
      ..write(obj.path);
  }
}
