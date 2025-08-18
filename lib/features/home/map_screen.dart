import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  final Map<String, dynamic>? extra;

  const MapScreen({super.key, this.extra});

  @override
  Widget build(BuildContext context) {
    final latitude = extra?['latitude'] ?? 0.0;
    final longitude = extra?['longitude'] ?? 0.0;
    final title = extra?['title'] ?? 'Unknown Location';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Latitude: $latitude'),
            Text('Longitude: $longitude'),
            Text('Location: $title'),
          ],
        ),
      ),
    );
  }
}