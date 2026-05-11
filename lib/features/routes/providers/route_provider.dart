import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/transport_route.dart';
import '../../../data/models/route_stop.dart';
import '../../../data/repositories/route_repository.dart';

final routeRepositoryProvider = Provider((ref) => RouteRepository());

final routesProvider = FutureProvider<List<TransportRoute>>((ref) async {
  return await ref.read(routeRepositoryProvider).getRoutes();
});

final filteredRoutesProvider = StateProvider<List<TransportRoute>>((ref) => []);
final searchQueryProvider = StateProvider<String>((ref) => '');
final filterTypeProvider = StateProvider<String?>((ref) => null);

final currentRouteProvider = FutureProvider.family<TransportRoute?, int>((ref, id) async {
  return await ref.read(routeRepositoryProvider).getRouteById(id);
});

final routeStopsProvider = FutureProvider.family<List<RouteStop>, int>((ref, routeId) async {
  return await ref.read(routeRepositoryProvider).getStopsForRoute(routeId);
});
