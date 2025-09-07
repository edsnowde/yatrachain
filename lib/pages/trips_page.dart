import 'package:flutter/material.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Later replace with Hive DB fetch
    List<Map<String, String>> dummyTrips = [
      {"start": "Kochi", "end": "Thrissur", "distance": "75 km"},
      {"start": "Kozhikode", "end": "Kannur", "distance": "90 km"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Your Trips")),
      body: ListView.builder(
        itemCount: dummyTrips.length,
        itemBuilder: (context, index) {
          final trip = dummyTrips[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text("${trip['start']} → ${trip['end']}"),
              subtitle: Text("Distance: ${trip['distance']}"),
              leading: const Icon(Icons.directions_car),
            ),
          );
        },
      ),
    );
  }
}
