// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_cdm_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadCdmModelAdapter extends TypeAdapter<DownloadCdmModel> {
  @override
  final typeId = 1;

  @override
  DownloadCdmModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadCdmModel(
      fields[0] as String,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadCdmModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hospitalName)
      ..writeByte(1)
      ..write(obj.isDownload);
  }
}
