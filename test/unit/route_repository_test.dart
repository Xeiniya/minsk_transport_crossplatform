import 'package:flutter_test/flutter_test.dart';
import 'package:minsk_transport_crossplatform/data/repositories/route_repository.dart';
import 'package:minsk_transport_crossplatform/data/models/transport_route.dart';

void main() {
  group('RouteRepository', () {
    late RouteRepository repository;
    
    setUp(() {
      repository = RouteRepository();
    });
    
    test('getRoutes returns list of routes', () async {
      final routes = await repository.getRoutes();
      expect(routes.isNotEmpty, true);
      expect(routes.length, greaterThan(0));
    });
    
    test('getRouteById returns correct route for existing id', () async {
      final route = await repository.getRouteById(1);
      expect(route, isNotNull);
      expect(route?.routeNumber, '1');
    });
    
    test('getRouteById returns null for non-existing id', () async {
      final route = await repository.getRouteById(999);
      expect(route, isNull);
    });
    
    test('getRoutes filters by bus type', () async {
      final routes = await repository.getRoutes(type: 'bus');
      expect(routes.every((route) => route.type == TransportType.bus), true);
    });
    
    test('getRoutes filters by trolley type', () async {
      final routes = await repository.getRoutes(type: 'trolley');
      expect(routes.every((route) => route.type == TransportType.trolley), true);
    });
    
    test('getRoutes filters by tram type', () async {
      final routes = await repository.getRoutes(type: 'tram');
      expect(routes.every((route) => route.type == TransportType.tram), true);
    });
    
    test('searchRoutes finds by route number', () async {
      final results = await repository.searchRoutes('1');
      expect(results.isNotEmpty, true);
    });
    
    test('getStopsForRoute returns stops', () async {
      final stops = await repository.getStopsForRoute(1);
      expect(stops.isNotEmpty, true);
      expect(stops.length, greaterThan(0));
    });
  });
}
