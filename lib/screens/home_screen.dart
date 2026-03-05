import 'package:flutter/material.dart';
import '../models/trip_model.dart';
import '../widgets/trip_card.dart';
import '../theme/app_colors.dart';
import '../widgets/create_trip_sheet.dart';
import 'trip_detail_screen.dart';
import 'weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Trip> trips = [];

  @override
  Widget build(BuildContext context) {

    final personalTrips = trips.where((trip) => !trip.isGroup).toList();
    final groupTrips = trips.where((trip) => trip.isGroup).toList();

    return Scaffold(
      backgroundColor: AppColors.background,

      /// APP BAR
      appBar: AppBar(
        title: const Text("PackLite"),
        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => CreateTripSheet(
                    onCreate: (trip) {
                      setState(() {
                        trips.add(trip);
                      });
                    },
                  ),
                );
              },

              icon: const Icon(Icons.add, size: 18),
              label: const Text("Create Trip"),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

        ],
      ),

      /// BOTTOM NAV BAR
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2), label: "Templates"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Shopping"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// JOIN TRIP CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.primaryGradientStart,
                    AppColors.primaryGradientEnd
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Got an invite code?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Join a group trip with friends",
                    style: TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 16),

                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.group_add),
                      label: const Text("Join Trip with Code"),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 16),

            /// WEATHER CARD
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    children: const [

                      Icon(
                        Icons.cloud,
                        size: 32,
                        color: Colors.blue,
                      ),

                      SizedBox(width: 10),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Weather Check",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          Text(
                            "Check weather before packing",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),

                        ],
                      ),

                    ],
                  ),

                  ElevatedButton(
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WeatherScreen(),
                        ),
                      );

                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),

                    child: const Text("Check"),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            /// PERSONAL TRIPS
            const Text(
              "Personal Trips",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            ...personalTrips.map(
                  (trip) => TripCard(
                trip: trip,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TripDetailScreen(trip: trip),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            /// GROUP TRIPS
            const Text(
              "Group Trips",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            ...groupTrips.map(
                  (trip) => TripCard(
                trip: trip,
              ),
            ),

          ],
        ),
      ),
    );
  }
}