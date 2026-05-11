import 'package:equatable/equatable.dart';

class RouteStop extends Equatable {
  final int? id;
  final int routeId;
  final String stopName;
  final double latitude;
  final double longitude;
  final int stopOrder;

  const RouteStop({
    this.id,
    required this.routeId,
    required this.stopName,
    required this.latitude,
    required this.longitude,
    required this.stopOrder,
  });

  factory RouteStop.fromMap(Map<String, dynamic> map) {
    return RouteStop(
      id: map['id'] as int?,
      routeId: map['route_id'] as int,
      stopName: map['stop_name'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      stopOrder: map['stop_order'] as int,
    );
  }

  @override
  List<Object?> get props => [id, routeId, stopName];
}
