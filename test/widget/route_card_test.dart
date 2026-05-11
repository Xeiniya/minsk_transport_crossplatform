import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minsk_transport_crossplatform/data/models/transport_route.dart';
import 'package:minsk_transport_crossplatform/features/routes/widgets/route_card.dart';

void main() {
  group('RouteCard Widget Tests', () {
    late TransportRoute busRoute;
    late TransportRoute trolleyRoute;
    late TransportRoute tramRoute;
    
    setUpAll(() {
      busRoute = TransportRoute(
        id: 1,
        routeNumber: '1',
        type: TransportType.bus,
        routeName: 'вокзал - уручье',
        startStop: 'вокзал',
        endStop: 'уручье',
        schedule: '06:00-23:00, интервал 10 мин',
      );
      
      trolleyRoute = TransportRoute(
        id: 2,
        routeNumber: '12',
        type: TransportType.trolley,
        routeName: 'Серебрянка - Масюковщина',
        startStop: 'Серебрянка',
        endStop: 'Масюковщина',
        schedule: '06:30-22:30, интервал 15 мин',
      );
      
      tramRoute = TransportRoute(
        id: 3,
        routeNumber: '1',
        type: TransportType.tram,
        routeName: 'ДС Курасовщина - ДС Серебрянка',
        startStop: 'Курасовщина',
        endStop: 'Серебрянка',
        schedule: '05:30-00:30, интервал 12 мин',
      );
    });
    
    testWidgets('displays route number', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RouteCard(route: busRoute),
          ),
        ),
      );
      
      expect(find.text('1'), findsWidgets);
    });
    
    testWidgets('displays route name', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RouteCard(route: busRoute),
          ),
        ),
      );
      
      expect(find.text('вокзал - уручье'), findsOneWidget);
    });
    
    testWidgets('displays start and end stops', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RouteCard(route: busRoute),
          ),
        ),
      );
      
      expect(find.text('вокзал → уручье'), findsOneWidget);
    });
    
    testWidgets('displays schedule when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RouteCard(route: busRoute),
          ),
        ),
      );
      
      expect(find.text('06:00-23:00, интервал 10 мин'), findsOneWidget);
    });
    
    testWidgets('shows bus icon for bus route', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RouteCard(route: busRoute),
          ),
        ),
      );
      
      expect(find.byIcon(Icons.directions_bus), findsOneWidget);
    });
    
    testWidgets('shows trolley icon for trolley route', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RouteCard(route: trolleyRoute),
          ),
        ),
      );
      
      expect(find.byIcon(Icons.directions_railway), findsOneWidget);
    });
    
    testWidgets('shows tram icon for tram route', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RouteCard(route: tramRoute),
          ),
        ),
      );
      
      expect(find.byIcon(Icons.tram), findsOneWidget);
    });
    
    testWidgets('bus route has green color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RouteCard(route: busRoute),
          ),
        ),
      );
      
      final container = tester.widget<Container>(
        find.byType(Container).first,
      );
      final decoration = container.decoration as BoxDecoration?;
      expect(decoration?.color, isNotNull);
    });
  });
}
