import 'package:flutter/material.dart';

import 'app_assets.dart';
import 'destination_data.dart';
import 'map_screen.dart';

class DetailScreen extends StatefulWidget {
  final Destination destination;

  const DetailScreen({super.key, required this.destination});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  void bookNow() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Booking'),
          content: Text(
            'Your booking for ${widget.destination.name} '
            'has been selected.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HERO IMAGE
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              widget.destination.image,
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Positioned(
                            top: 12,
                            left: 12,
                            child: _RoundButton(
                              icon: Icons.arrow_back,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),

                          Positioned(
                            top: 12,
                            right: 48,
                            child: _RoundButton(
                              icon: Icons.ios_share,
                              onTap: () {},
                            ),
                          ),

                          Positioned(
                            top: 12,
                            right: 12,
                            child: ValueListenableBuilder<Set<String>>(
                              valueListenable: favoriteIds,
                              builder: (context, favorites, child) {
                                final bool isFavorite = favorites.contains(
                                  widget.destination.id,
                                );

                                return _RoundButton(
                                  icon: isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.black,
                                  onTap: () {
                                    toggleFavorite(widget.destination.id);
                                  },
                                );
                              },
                            ),
                          ),

                          // PHOTO STRIP
                          Positioned(
                            left: 20,
                            right: 20,
                            bottom: 12,
                            child: Container(
                              height: 48,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.55),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  _SmallImage(widget.destination.image),
                                  _SmallImage(AppAssets.colosseumCard),
                                  _SmallImage(AppAssets.bromo),
                                  _SmallImage(widget.destination.image),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.55),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '+5',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // TITLE
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.destination.name,
                                  style: const TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  widget.destination.city,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            widget.destination.price,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // LOCATION
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      title: 'Location',
                      text: widget.destination.address,
                    ),

                    const SizedBox(height: 12),

                    // OPENING
                    _InfoRow(
                      icon: Icons.access_time,
                      title: 'OPEN',
                      text: widget.destination.openingTime,
                    ),

                    const SizedBox(height: 18),

                    // MAP
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  MapScreen(destination: widget.destination),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.asset(
                                AppAssets.map,
                                width: double.infinity,
                                height: 145,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                            const Positioned.fill(
                              child: Center(
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // BOOK NOW
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: bookNow,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF17085B),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            'Book now',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // SMALL BOTTOM NAV
            Container(
              height: 55,
              margin: const EdgeInsets.fromLTRB(15, 0, 15, 8),
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
          ],
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _RoundButton({
    required this.icon,
    required this.onTap,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}

class _SmallImage extends StatelessWidget {
  final String image;

  const _SmallImage(this.image);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Image.asset(image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _InfoRow({required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0xFFF5F5F5),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 15),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  text,
                  style: const TextStyle(fontSize: 8, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
