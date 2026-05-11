// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_stop.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RouteStopAdapter extends TypeAdapter<RouteStop> {
  @override
  final int typeId = 1;

  @override
  RouteStop read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RouteStop(
      id: fields[0] as int?,
      routeId: fields[1] as int,
      stopName: fields[2] as String,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
      stopOrder: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RouteStop obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.routeId)
      ..writeByte(2)
      ..write(obj.stopName)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.stopOrder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteStopAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
