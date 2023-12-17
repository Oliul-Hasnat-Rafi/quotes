// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class modelhiveAdapter extends TypeAdapter<model_hive> {
  @override
  final int typeId = 0;

  @override
  model_hive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return model_hive(
      quotes: fields[0] as String,
      authorname: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, model_hive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.quotes)
      ..writeByte(1)
      ..write(obj.authorname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is modelhiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
