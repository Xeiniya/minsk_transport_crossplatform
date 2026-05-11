import 'package:hive_flutter/hive_flutter.dart';
import '../models/transport_route.dart';
import '../models/route_stop.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  
  DatabaseHelper._internal();
  
  static DatabaseHelper get instance {
    _instance ??= DatabaseHelper._internal();
    return _instance!;
  }
  
  final List<Map<String, dynamic>> _routes = [
    {'id': 1, 'route_number': '1', 'transport_type': 'bus', 'route_name': 'вокзал - уручье', 'start_stop': 'вокзал', 'end_stop': 'уручье', 'schedule': '06:00-23:00, интервал 10 мин', 'is_active': 1},
    {'id': 2, 'route_number': '12', 'transport_type': 'trolley', 'route_name': 'Серебрянка - Масюковщина', 'start_stop': 'Серебрянка', 'end_stop': 'Масюковщина', 'schedule': '06:30-22:30, интервал 15 мин', 'is_active': 1},
    {'id': 3, 'route_number': '1', 'transport_type': 'tram', 'route_name': 'ДС Курасовщина - ДС Серебрянка', 'start_stop': 'Курасовщина', 'end_stop': 'Серебрянка', 'schedule': '05:30-00:30, интервал 12 мин', 'is_active': 1},
    {'id': 4, 'route_number': '100', 'transport_type': 'bus', 'route_name': 'ДС Веснянка - ДС Ангарская', 'start_stop': 'ДС Веснянка', 'end_stop': 'ДС Ангарская', 'schedule': '06:00-23:00, интервал 8 мин', 'is_active': 1},
    {'id': 5, 'route_number': '53', 'transport_type': 'trolley', 'route_name': 'ДС Карастояновой - ДС Кунцевщина', 'start_stop': 'Карастояновой', 'end_stop': 'Кунцевщина', 'schedule': '06:00-23:00, интервал 12 мин', 'is_active': 1},
  ];
  
  final List<Map<String, dynamic>> _stops = [
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
  ];
  
  Future<void> initDatabase() async {
    final cacheBox = Hive.box('cache');
    await cacheBox.put('routes', _routes);
    await cacheBox.put('stops', _stops);
  }
  
  Future<List<Map<String, dynamic>>> getRoutes({String? type}) async {
    var routes = List<Map<String, dynamic>>.from(_routes);
    if (type != null && type.isNotEmpty) {
      routes = routes.where((route) => route['transport_type'] == type).toList();
    }
    return routes;
  }
  
  Future<Map<String, dynamic>?> getRouteById(int id) async {
    try {
      return _routes.firstWhere((route) => route['id'] == id);
    } catch (e) {
      return null;
    }
  }
  
  Future<List<Map<String, dynamic>>> getStopsForRoute(int routeId) async {
    return _stops.where((stop) => stop['route_id'] == routeId).toList();
  }
  
  Future<void> addToFavorites(int routeId) async {
    final favoritesBox = Hive.box('favorites');
    final favorites = favoritesBox.get('routes', defaultValue: <int>[]);
    if (favorites is List) {
      final list = List<int>.from(favorites);
      if (!list.contains(routeId)) {
        list.add(routeId);
        await favoritesBox.put('routes', list);
      }
    }
  }
  
  Future<void> removeFromFavorites(int routeId) async {
    final favoritesBox = Hive.box('favorites');
    final favorites = favoritesBox.get('routes', defaultValue: <int>[]);
    if (favorites is List) {
      final list = List<int>.from(favorites);
      list.remove(routeId);
      await favoritesBox.put('routes', list);
    }
  }
  
  Future<List<int>> getFavorites() async {
    final favoritesBox = Hive.box('favorites');
    final favorites = favoritesBox.get('routes', defaultValue: <int>[]);
    return List<int>.from(favorites);
  }
}