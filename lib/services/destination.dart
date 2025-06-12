import 'dart:math';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:forclient_travelapp/models/destination.dart';

Future<List<Destination>> getDestinations({
  String? query,
  String? filter,
}) async {
  final String response = await rootBundle.loadString(
    'assets/data/destinations.json',
  );
  final List<dynamic> data = json.decode(response);
  List<Destination> destinations =
      data.map((item) => Destination.fromJson(item)).toList();

  if (query != null && query.isNotEmpty) {
    destinations =
        destinations.where((destination) {
          final name = destination.name?.toLowerCase() ?? '';
          return name.contains(query.toLowerCase());
        }).toList();
  }

  if (filter == 'rating') {
    destinations.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
  } else if (filter == 'price') {
    destinations.sort((a, b) => (a.budget).compareTo(b.budget));
  } else if (filter == 'alam') {
    destinations = destinations
        .where(
          (destination) =>
              destination.subCategories?.contains('Wisata Alam') ?? false,
        )
        .toList();
  } else if (filter == 'kota') {
    destinations = destinations
        .where(
          (destination) =>
              destination.subCategories?.contains('Wisata Kota') ?? false,
        )
        .toList();
  }

  return destinations;
}

/**
 * For get recomendation with saw jarak user ke wisata
 */

class ScoredDestination {
  final Destination dest;
  final double score;
  final double distance;
  ScoredDestination(this.dest, this.score, this.distance);
}

Future<List<Destination>> getRecommendationsSAW({
  required List<Destination> destinations,
  required double userLat,
  required double userLon,
  required Map<String, double> weights, // e.g. {'distance':0.4,'rating':0.3,'budget':0.3}
}) async {
  // 1. Hitung distance untuk tiap destinasi
  final distances = destinations.map((d) {
    final dist = _calculateDistance(userLat, userLon, d.latitude, d.longitude);
    return dist;
  }).toList();

  // 2. Kumpulkan nilai tiap kriteria
  final ratings = destinations.map((d) => d.rating ?? 0.0).toList();
  final budgets = destinations.map((d) => d.budget.toDouble()).toList();

  // 3. Cari min/max untuk normalisasi
  final maxRating = ratings.reduce(max);
  final minDistance = distances.reduce(min);
  final minBudget = budgets.reduce(min);

  // 4. Hitung skor SAW tiap destinasi
  List<ScoredDestination> scored = [];
  for (int i = 0; i < destinations.length; i++) {
    // Normalisasi
    final rRating = (maxRating > 0) ? ratings[i] / maxRating : 0;
    final rDistance = (distances[i] > 0) ? minDistance / distances[i] : 0;
    final rBudget = (budgets[i] > 0) ? minBudget / budgets[i] : 0;

    // Weighted sum
    final score = 
        weights['rating']! * rRating +
        weights['distance']! * rDistance +
        weights['budget']! * rBudget;

    scored.add(ScoredDestination(destinations[i], score, distances[i]));
  }

  // 5. Urutkan berdasarkan score tertinggi
  scored.sort((a, b) => b.score.compareTo(a.score));

  // Kembalikan daftar Destination terurut
  return scored.map((sd) => sd.dest).toList();
}

double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371; // km
  final dLat = _deg2rad(lat2 - lat1);
  final dLon = _deg2rad(lon2 - lon1);
  final a = sin(dLat/2)*sin(dLat/2) +
      cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) *
      sin(dLon/2)*sin(dLon/2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return R * c;
}

double _deg2rad(double deg) => deg * pi / 180;



/**
 *  For get trading with saw rating
 */

Future<List<Destination>> getTrendingDestinations({
  required String category,
  String? query,
  String? filter,
}) async {
  List<Destination> destinations = await getDestinations();

  if (filter == 'rating') {
    destinations.sort((a, b) => b.rating!.compareTo(a.rating!));
  } else if (filter == 'price') {
    destinations.sort((a, b) => a.budget.compareTo(b.budget));
  } else if (filter == 'alam') {
    destinations = destinations
        .where(
          (destination) =>
              destination.subCategories?.contains('Wisata Alam') ?? false,
        )
        .toList();
  } else if (filter == 'kota') {
    destinations = destinations
        .where(
          (destination) =>
              destination.subCategories?.contains('Wisata Kota') ?? false,
        )
        .toList();
  }

  return destinations.where((destination) {
    final isHighRated =
        destination.rating != null && destination.rating! > 4.3;

    final matchCategory = category == "All" || destination.category == category;

    final matchQuery =
        query == null ||
        query.isEmpty ||
        destination.name!.toLowerCase().contains(query.toLowerCase());

    return isHighRated && matchCategory && matchQuery;
  }).toList();
}

Future<List<String>> getCategoryList() async {
  final List<Destination> destinations = await getDestinations();
  final categorySet = <String>{};

  for (final destination in destinations) {
    if (destination.category != null) {
      categorySet.add(destination.category!);
    }
  }

  final categoryList = ['All', ...categorySet.toList()..sort()];
  return categoryList;
}