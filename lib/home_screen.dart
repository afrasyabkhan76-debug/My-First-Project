import 'package:flutter/material.dart';

import 'app_assets.dart';
import 'destination_data.dart';
import 'detail_screen.dart';
import 'map_screen.dart';
import 'simple_tab_screen.dart';
import 'widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  int selectedNav = 0;

  final TextEditingController searchController = TextEditingController();

  final List<String> tabs = ['All', 'Popular', 'Recommended', 'Most Viewed'];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void openDetail(Destination destination) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(destination: destination)),
    );
  }

  List<Destination> get filteredDestinations {
    final String search = searchController.text.trim().toLowerCase();

    List<Destination> result;

    if (selectedNav == 3) {
      result = destinations
          .where((item) => favoriteIds.value.contains(item.id))
          .toList();
    } else {
      result = List<Destination>.from(destinations);
    }

    if (selectedTab == 1) {
      result = result.where((item) => item.category == 'Popular').toList();
    }

    if (selectedTab == 2) {
      result = result.where((item) => item.category == 'Recommended').toList();
    }

    if (selectedTab == 3) {
      result = result.where((item) => item.category == 'Most Viewed').toList();
    }

    if (search.isNotEmpty) {
      result = result.where((item) {
        return item.name.toLowerCase().contains(search) ||
            item.city.toLowerCase().contains(search);
      }).toList();
    }

    return result;
  }

  void changeNavigation(int index) {
    setState(() {
      selectedNav = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const SimpleTabScreen(title: 'Explore', icon: Icons.explore),
        ),
      );
    }

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const SimpleTabScreen(title: 'Profile', icon: Icons.person),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<String>>(
      valueListenable: favoriteIds,
      builder: (context, favorites, child) {
        final List<Destination> items = filteredDestinations;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 25, 24, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // HEADER
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Where do\nyou want to go?',
                                style: TextStyle(
                                  fontSize: 24,
                                  height: 1.05,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            ClipOval(
                              child: Image.asset(
                                AppAssets.avatar,
                                width: 42,
                                height: 42,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 42,
                                    height: 42,
                                    color: Colors.green.shade50,
                                    child: const Icon(Icons.person),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 22),

                        // SEARCH
                        Container(
                          height: 36,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF399BFF),
                              width: 1.3,
                            ),
                          ),
                          child: TextField(
                            controller: searchController,
                            onChanged: (_) {
                              setState(() {});
                            },
                            style: const TextStyle(fontSize: 11),
                            decoration: const InputDecoration(
                              hintText: 'Discover city',
                              hintStyle: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 15,
                                color: Colors.grey,
                              ),
                              suffixIcon: Icon(
                                Icons.tune,
                                size: 14,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 10),
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        const Text(
                          'Explore Cities',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // TABS
                        SizedBox(
                          height: 20,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: tabs.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 20),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTab = index;
                                  });
                                },
                                child: Text(
                                  tabs[index],
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: selectedTab == index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: selectedTab == index
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 8),

                        // DESTINATION CARDS
                        if (items.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(35),
                            child: Center(
                              child: Text(
                                'No saved destinations',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        else
                          SizedBox(
                            height: 118,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: items.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 8),
                              itemBuilder: (context, index) {
                                return DestinationCard(
                                  destination: items[index],
                                  onTap: () {
                                    openDetail(items[index]);
                                  },
                                );
                              },
                            ),
                          ),

                        const SizedBox(height: 25),

                        const Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 14),

                        SizedBox(
                          height: 75,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              CategoryCircle(
                                icon: Icons.landscape,
                                title: 'Mountain',
                                onTap: () {},
                              ),
                              const SizedBox(width: 13),
                              CategoryCircle(
                                icon: Icons.beach_access,
                                title: 'Beach',
                                onTap: () {},
                              ),
                              const SizedBox(width: 13),
                              CategoryCircle(
                                icon: Icons.park,
                                title: 'Park',
                                onTap: () {},
                              ),
                              const SizedBox(width: 13),
                              CategoryCircle(
                                icon: Icons.forest,
                                title: 'Nature',
                                onTap: () {},
                              ),
                              const SizedBox(width: 13),
                              CategoryCircle(
                                icon: Icons.location_city,
                                title: 'City',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        // MAP BUTTON
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    MapScreen(destination: destinations.first),
                              ),
                            );
                          },
                          child: Container(
                            height: 42,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F4F6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.map_outlined,
                                  size: 18,
                                  color: Color(0xFF17085B),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Explore on map',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                TravelBottomNav(
                  selectedIndex: selectedNav,
                  onChanged: changeNavigation,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
