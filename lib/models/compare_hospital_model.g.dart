// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compare_hospital_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompareHospitalModelAdapter extends TypeAdapter<CompareHospitalModel> {
  @override
  final typeId = 2;

  @override
  CompareHospitalModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompareHospitalModel(
      fields[0] as String,
      fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CompareHospitalModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hospitalName)
      ..writeByte(1)
      ..write(obj.isAddedToCompare);
  }
}
