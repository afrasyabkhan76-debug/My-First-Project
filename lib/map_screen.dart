import 'package:flutter/material.dart';

import 'app_assets.dart';
import 'destination_data.dart';
import 'detail_screen.dart';

class MapScreen extends StatelessWidget {
  final Destination destination;

  const MapScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // MAP
          Positioned.fill(child: Image.asset(AppAssets.map, fit: BoxFit.cover)),

          // TOP BAR
          Positioned(
            top: 45,
            left: 18,
            right: 18,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, size: 20),
                  ),
                  Expanded(
                    child: Text(
                      '${destination.name}, ${destination.city}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // LOCATION MARKER
          const Positioned(
            top: 220,
            left: 175,
            child: Icon(Icons.location_on, color: Colors.red, size: 42),
          ),

          // DESTINATION CARD
          Positioned(
            left: 18,
            right: 18,
            bottom: 85,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(destination: destination),
                  ),
                );
              },
              child: Container(
                height: 90,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        destination.image,
                        width: 80,
                        height: 74,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            destination.name,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            destination.city,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '${destination.rating} / 5',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2589FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.navigation,
                        color: Colors.white,
                        size: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // BOTTOM NAV
          Positioned(
            left: 15,
            right: 15,
            bottom: 8,
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xFF17085B),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.home_outlined, color: Colors.white, size: 19),
                  Icon(Icons.person_outline, color: Colors.white, size: 19),
                  Icon(Icons.explore_outlined, color: Colors.white, size: 19),
                  Icon(Icons.bookmark_border, color: Colors.white, size: 19),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
