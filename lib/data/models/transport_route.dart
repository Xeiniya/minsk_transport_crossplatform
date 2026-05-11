import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

enum TransportType { bus, trolley, tram }

extension TransportTypeExtension on TransportType {
  String get value {
    switch (this) {
      case TransportType.bus: return 'bus';
      case TransportType.trolley: return 'trolley';
      case TransportType.tram: return 'tram';
    }
  }
  
  String get displayName {
    switch (this) {
      case TransportType.bus: return 'Автобус';
      case TransportType.trolley: return 'Троллейбус';
      case TransportType.tram: return 'Трамвай';
    }
  }
  
  IconData get icon {
    switch (this) {
      case TransportType.bus: return Icons.directions_bus;
      case TransportType.trolley: return Icons.directions_railway;
      case TransportType.tram: return Icons.tram;
    }
  }
  
  Color get color {
    switch (this) {
      case TransportType.bus: return Colors.green;
      case TransportType.trolley: return Colors.blue;
      case TransportType.tram: return Colors.red;
    }
  }
}

class TransportRoute extends Equatable {
  final int? id;
  final String routeNumber;
  final TransportType type;
  final String routeName;
  final String startStop;
  final String endStop;
  final String? schedule;
  final bool isActive;

  const TransportRoute({
    this.id,
    required this.routeNumber,
    required this.type,
    required this.routeName,
    required this.startStop,
    required this.endStop,
    this.schedule,
    this.isActive = true,
  });

  factory TransportRoute.fromMap(Map<String, dynamic> map) {
    TransportType parseType(String value) {
      switch (value) {
        case 'bus': return TransportType.bus;
        case 'trolley': return TransportType.trolley;
        case 'tram': return TransportType.tram;
        default: return TransportType.bus;
      }
    }
    
    return TransportRoute(
      id: map['id'] as int?,
      routeNumber: map['route_number'] as String,
      type: parseType(map['transport_type'] as String),
      routeName: map['route_name'] as String,
      startStop: map['start_stop'] as String,
      endStop: map['end_stop'] as String,
      schedule: map['schedule'] as String?,
      isActive: (map['is_active'] as int?) == 1,
    );
  }

  @override
  List<Object?> get props => [id, routeNumber, type, routeName];
}
