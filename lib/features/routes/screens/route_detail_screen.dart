import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/route_repository.dart';
import '../../../data/models/transport_route.dart';
import '../../../data/models/route_stop.dart';
import '../../../core/widgets/loading_widget.dart';
import 'map_screen.dart';

class RouteDetailScreen extends ConsumerStatefulWidget {
  final int routeId;
  
  const RouteDetailScreen({super.key, required this.routeId});

  @override
  ConsumerState<RouteDetailScreen> createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends ConsumerState<RouteDetailScreen> {
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
      appBar: AppBar(title: const Text('Детали маршрута')),
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
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Информация о маршруте
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [route.type.color, route.type.color.withOpacity(0.7)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(route.type.icon, size: 40, color: Colors.white),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Маршрут ${route.routeNumber}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${route.startStop} → ${route.endStop}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Расписание
                if (route.schedule != null) ...[
                  const Text(
                    'Расписание',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.schedule),
                      title: Text(route.schedule!),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                
                // Остановки
                const Text(
                  'Остановки',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                FutureBuilder(
                  future: _stopsFuture,
                  builder: (context, stopsSnapshot) {
                    if (stopsSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    if (stopsSnapshot.hasError) {
                      return Text('Ошибка: ${stopsSnapshot.error}');
                    }
                    
                    final stops = stopsSnapshot.data ?? [];
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: stops.length,
                      itemBuilder: (context, index) {
                        final stop = stops[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(stop.stopName),
                            trailing: const Icon(Icons.location_on),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
                
                // Кнопка карты
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MapScreen(routeId: widget.routeId),
                        ),
                      );
                    },
                    icon: const Icon(Icons.map),
                    label: const Text('Показать на карте'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
