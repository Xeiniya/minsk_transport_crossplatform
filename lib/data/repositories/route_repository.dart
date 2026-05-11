import '../models/transport_route.dart';
import '../models/route_stop.dart';

class RouteRepository {
  // Статические данные маршрутов Минска
  final List<Map<String, dynamic>> _routesData = [
    {'id': 1, 'route_number': '1', 'transport_type': 'bus', 'route_name': 'вокзал - уручье', 'start_stop': 'вокзал', 'end_stop': 'уручье', 'schedule': '06:00-23:00, интервал 10 мин', 'is_active': 1},
    {'id': 2, 'route_number': '12', 'transport_type': 'trolley', 'route_name': 'Серебрянка - Масюковщина', 'start_stop': 'Серебрянка', 'end_stop': 'Масюковщина', 'schedule': '06:30-22:30, интервал 15 мин', 'is_active': 1},
    {'id': 3, 'route_number': '1', 'transport_type': 'tram', 'route_name': 'ДС Курасовщина - ДС Серебрянка', 'start_stop': 'Курасовщина', 'end_stop': 'Серебрянка', 'schedule': '05:30-00:30, интервал 12 мин', 'is_active': 1},
    {'id': 4, 'route_number': '100', 'transport_type': 'bus', 'route_name': 'ДС Веснянка - ДС Ангарская', 'start_stop': 'ДС Веснянка', 'end_stop': 'ДС Ангарская', 'schedule': '06:00-23:00, интервал 8 мин', 'is_active': 1},
    {'id': 5, 'route_number': '53', 'transport_type': 'trolley', 'route_name': 'ДС Карастояновой - ДС Кунцевщина', 'start_stop': 'Карастояновой', 'end_stop': 'Кунцевщина', 'schedule': '06:00-23:00, интервал 12 мин', 'is_active': 1},
    {'id': 6, 'route_number': '2', 'transport_type': 'bus', 'route_name': 'ДС Сосны - ДС Веснянка', 'start_stop': 'ДС Сосны', 'end_stop': 'ДС Веснянка', 'schedule': '06:00-23:00, интервал 15 мин', 'is_active': 1},
    {'id': 7, 'route_number': '3', 'transport_type': 'tram', 'route_name': 'ДС Серебрянка - ДС Курасовщина', 'start_stop': 'Серебрянка', 'end_stop': 'Курасовщина', 'schedule': '06:00-23:00, интервал 12 мин', 'is_active': 1},
  ];
  
  final List<Map<String, dynamic>> _stopsData = [
    {'route_id': 1, 'stop_name': 'вокзал', 'latitude': 53.8902, 'longitude': 27.5507, 'stop_order': 1},
    {'route_id': 1, 'stop_name': 'площадь Ленина', 'latitude': 53.8956, 'longitude': 27.5534, 'stop_order': 2},
    {'route_id': 1, 'stop_name': 'уручье', 'latitude': 53.9444, 'longitude': 27.6848, 'stop_order': 3},
    {'route_id': 2, 'stop_name': 'Серебрянка', 'latitude': 53.8612, 'longitude': 27.6161, 'stop_order': 1},
    {'route_id': 2, 'stop_name': 'пл. Калинина', 'latitude': 53.8805, 'longitude': 27.5991, 'stop_order': 2},
    {'route_id': 2, 'stop_name': 'Масюковщина', 'latitude': 53.8742, 'longitude': 27.4672, 'stop_order': 3},
    {'route_id': 3, 'stop_name': 'Курасовщина', 'latitude': 53.8539, 'longitude': 27.4906, 'stop_order': 1},
    {'route_id': 3, 'stop_name': 'Серебрянка', 'latitude': 53.8612, 'longitude': 27.6161, 'stop_order': 2},
    {'route_id': 4, 'stop_name': 'ДС Веснянка', 'latitude': 53.9378, 'longitude': 27.6860, 'stop_order': 1},
    {'route_id': 4, 'stop_name': 'станция метро Уручье', 'latitude': 53.9444, 'longitude': 27.6848, 'stop_order': 2},
    {'route_id': 5, 'stop_name': 'Карастояновой', 'latitude': 53.8865, 'longitude': 27.5625, 'stop_order': 1},
    {'route_id': 5, 'stop_name': 'ДС Кунцевщина', 'latitude': 53.8765, 'longitude': 27.5815, 'stop_order': 2},
    {'route_id': 6, 'stop_name': 'ДС Сосны', 'latitude': 53.9075, 'longitude': 27.5882, 'stop_order': 1},
    {'route_id': 6, 'stop_name': 'ДС Веснянка', 'latitude': 53.9378, 'longitude': 27.6860, 'stop_order': 2},
    {'route_id': 7, 'stop_name': 'Серебрянка', 'latitude': 53.8612, 'longitude': 27.6161, 'stop_order': 1},
    {'route_id': 7, 'stop_name': 'Курасовщина', 'latitude': 53.8539, 'longitude': 27.4906, 'stop_order': 2},
  ];
  
  Future<List<TransportRoute>> getRoutes({String? type}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    var routes = _routesData.map((map) => TransportRoute.fromMap(map)).toList();
    if (type != null && type.isNotEmpty) {
      routes = routes.where((route) => route.type.value == type).toList();
    }
    return routes;
  }
  
  Future<TransportRoute?> getRouteById(int id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      final routeData = _routesData.firstWhere((route) => route['id'] == id);
      return TransportRoute.fromMap(routeData);
    } catch (e) {
      return null;
    }
  }
  
  Future<List<RouteStop>> getStopsForRoute(int routeId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final stops = _stopsData
        .where((stop) => stop['route_id'] == routeId)
        .map((stop) => RouteStop.fromMap(stop))
        .toList();
    return stops;
  }
  
  // Добавленный метод searchRoutes
  Future<List<TransportRoute>> searchRoutes(String query) async {
    final routes = await getRoutes();
    if (query.isEmpty) return routes;
    
    final lowerQuery = query.toLowerCase();
    return routes.where((route) =>
      route.routeNumber.toLowerCase().contains(lowerQuery) ||
      route.routeName.toLowerCase().contains(lowerQuery) ||
      route.startStop.toLowerCase().contains(lowerQuery) ||
      route.endStop.toLowerCase().contains(lowerQuery)
    ).toList();
  }
}

Future<List<TransportRoute>> getRoutes({String? type}) async {
  try {
    await Future.delayed(const Duration(milliseconds: 100));
    var routes = _routesData.map((map) => TransportRoute.fromMap(map)).toList();
    if (type != null && type.isNotEmpty) {
      routes = routes.where((route) => route.type.value == type).toList();
    }
    return routes;
  } catch (e, stackTrace) {
    debugPrint('Error in getRoutes: $e');
    debugPrint('Stack trace: $stackTrace');
    return [];
  }
}
