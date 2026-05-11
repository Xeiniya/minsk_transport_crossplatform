import 'package:flutter/material.dart';
import '../../../data/models/route_stop.dart';

class StopCard extends StatelessWidget {
  final RouteStop stop;
  final int index;
  
  const StopCard({super.key, required this.stop, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${index + 1}'),
        ),
        title: Text(stop.stopName),
        trailing: const Icon(Icons.location_on, color: Colors.blue),
        onTap: () {
          // Show stop details
        },
      ),
    );
  }
}
