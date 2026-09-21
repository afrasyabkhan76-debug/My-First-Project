import 'package:flutter/material.dart';

import 'app_assets.dart';

class Destination {
  final String id;
  final String name;
  final String city;
  final String price;
  final String image;
  final String category;
  final String address;
  final String openingTime;
  final double rating;

  const Destination({
    required this.id,
    required this.name,
    required this.city,
    required this.price,
    required this.image,
    required this.category,
    required this.address,
    required this.openingTime,
    required this.rating,
  });
}

const List<Destination> destinations = [
  Destination(
    id: 'colosseum',
    name: 'Colosseum',
    city: 'Rome',
    price: '\$20',
    image: AppAssets.colosseum,
    category: 'Popular',
    address: 'Piazza del Colosseo, Rome',
    openingTime: '09:00 AM',
    rating: 4.7,
  ),
  Destination(
    id: 'bromo',
    name: 'Mount Bromo',
    city: 'Indonesia',
    price: '\$25',
    image: AppAssets.bromo,
    category: 'Recommended',
    address: 'East Java, Indonesia',
    openingTime: '05:00 AM',
    rating: 4.8,
  ),
  Destination(
    id: 'colosseum-card',
    name: 'Colosseum',
    city: 'Rome',
    price: '\$20',
    image: AppAssets.colosseumCard,
    category: 'Most Viewed',
    address: 'Piazza del Colosseo, Rome',
    openingTime: '09:00 AM',
    rating: 4.7,
  ),
];

final ValueNotifier<Set<String>> favoriteIds = ValueNotifier<Set<String>>(
  <String>{},
);

void toggleFavorite(String id) {
  final Set<String> updated = Set<String>.from(favoriteIds.value);

  if (updated.contains(id)) {
    updated.remove(id);
  } else {
    updated.add(id);
  }

  favoriteIds.value = updated;
}
