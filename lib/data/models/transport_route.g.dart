// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_route.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransportRouteAdapter extends TypeAdapter<TransportRoute> {
  @override
  final int typeId = 0;

  @override
  TransportRoute read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransportRoute(
      id: fields[0] as int?,
      routeNumber: fields[1] as String,
      type: fields[2] as TransportType,
      routeName: fields[3] as String,
      startStop: fields[4] as String,
      endStop: fields[5] as String,
      schedule: fields[6] as String?,
      isActive: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TransportRoute obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.routeNumber)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.routeName)
      ..writeByte(4)
      ..write(obj.startStop)
      ..writeByte(5)
      ..write(obj.endStop)
      ..writeByte(6)
      ..write(obj.schedule)
      ..writeByte(7)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransportRouteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
