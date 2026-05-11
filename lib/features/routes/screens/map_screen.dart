import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/route_repository.dart';
import '../../../data/models/transport_route.dart';
import '../../../data/models/route_stop.dart';
import '../../../core/widgets/loading_widget.dart';

class MapScreen extends ConsumerStatefulWidget {
  final int routeId;
  
  const MapScreen({super.key, required this.routeId});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  late Future<TransportRoute?> _routeFuture;
  late Future<List<RouteStop>> _stopsFuture;
  final RouteRepository _repository = RouteRepository();

  @override
  void initState() {
    super.initState();
    _routeFuture = _repository.getRouteById(widget.routeId);
    _stopsFuture = _repository.getStopsForRoute(widget.routeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Карта маршрута')),
      body: FutureBuilder(
        future: _routeFuture,
        builder: (context, routeSnapshot) {
          if (routeSnapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          
          if (routeSnapshot.hasError) {
            return Center(child: Text('Ошибка: ${routeSnapshot.error}'));
          }
          
          final route = routeSnapshot.data;
          if (route == null) {
            return const Center(child: Text('Маршрут не найден'));
          }
          
          return FutureBuilder(
            future: _stopsFuture,
            builder: (context, stopsSnapshot) {
              if (stopsSnapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              }
              
              final stops = stopsSnapshot.data ?? [];
              
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: route.type.color,
                    child: Row(
                      children: [
                        Icon(route.type.icon, color: Colors.white),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Маршрут ${route.routeNumber}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '${stops.length} остановок',
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: stops.length,
                      itemBuilder: (context, index) {
                        final stop = stops[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: route.type.color,
                              child: Text('${index + 1}'),
                            ),
                            title: Text(stop.stopName),
                            subtitle: Text('${stop.latitude}, ${stop.longitude}'),
                            trailing: const Icon(Icons.location_on),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
