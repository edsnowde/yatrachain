import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class TripTrackingPage extends StatefulWidget {
  const TripTrackingPage({super.key});

  @override
  State<TripTrackingPage> createState() => _TripTrackingPageState();
}

class _TripTrackingPageState extends State<TripTrackingPage> {
  GoogleMapController? _mapController;
  LatLng? _currentLocation;
  bool _isTracking = false;
  final TextEditingController _searchController = TextEditingController();

  // Add trip points list
  final List<LatLng> _tripPoints = [];

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });

    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_currentLocation!, 16),
    );
  }

  // Remove _toggleTracking

  void _searchLocation() async {
    // For now, just show a snackbar (later integrate Places API)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Searching for: ${_searchController.text}")),
    );
  }

  // Add location stream logic
  void _startLocationStream() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // meters
      ),
    ).listen((Position position) {
      LatLng newPosition = LatLng(position.latitude, position.longitude);
      double speed = position.speed * 3.6; // m/s → km/h

      if (!_isTracking && speed > 5) {
        // Trip started
        setState(() => _isTracking = true);
        _tripPoints.clear();
        _tripPoints.add(newPosition);
      } else if (_isTracking && speed < 1) {
        // Trip stopped
        setState(() => _isTracking = false);
        _saveTrip(); // store trip details locally
      } else if (_isTracking) {
        _tripPoints.add(newPosition);
      }

      setState(() => _currentLocation = newPosition);
      _mapController?.animateCamera(CameraUpdate.newLatLng(newPosition));
    });
  }

  // Dummy save trip function
  void _saveTrip() {
    // You can implement local storage logic here
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Trip saved locally!")));
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _startLocationStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Map
                GoogleMap(
                  onMapCreated: (controller) => _mapController = controller,
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation!,
                    zoom: 15,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  // Optionally, show trip polyline
                  polylines: {
                    if (_tripPoints.length > 1)
                      Polyline(
                        polylineId: const PolylineId('trip'),
                        points: _tripPoints,
                        color: Colors.blue,
                        width: 5,
                      ),
                  },
                ),

                // Search Bar
                Positioned(
                  top: 50,
                  left: 15,
                  right: 15,
                  child: Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(30),
                    child: TextField(
                      controller: _searchController,
                      onSubmitted: (_) => _searchLocation(),
                      decoration: InputDecoration(
                        hintText: "Search for a place...",
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Status indicator at bottom-left
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: _isTracking ? Colors.green : Colors.redAccent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      _isTracking ? "Trip In Progress" : "Trip Stopped",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
