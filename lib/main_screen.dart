import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/trip_tracking_page.dart';
import 'pages/trips_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(onNavigateToMap: () => _onTabTapped(2)), // ✅ callback here
      const TripsPage(),
      const TripTrackingPage(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Trips"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
        ],
      ),
    );
  }
}
