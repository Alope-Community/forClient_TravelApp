import 'dart:math';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:forclient_travelapp/models/destination.dart';
import 'package:forclient_travelapp/utils/position.dart';
import 'package:geolocator/geolocator.dart';

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
    destinations =
        destinations
            .where(
              (destination) =>
                  destination.subCategories?.contains('Wisata Alam') ?? false,
            )
            .toList();
  } else if (filter == 'kota') {
    destinations =
        destinations
            .where(
              (destination) =>
                  destination.subCategories?.contains('Wisata Kota') ?? false,
            )
            .toList();
  }

  return destinations;
}

double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371; // km
  final dLat = _deg2rad(lat2 - lat1);
  final dLon = _deg2rad(lon2 - lon1);
  final a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
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
    destinations =
        destinations
            .where(
              (destination) =>
                  destination.subCategories?.contains('Wisata Alam') ?? false,
            )
            .toList();
  } else if (filter == 'kota') {
    destinations =
        destinations
            .where(
              (destination) =>
                  destination.subCategories?.contains('Wisata Kota') ?? false,
            )
            .toList();
  }

  return destinations.where((destination) {
    final isHighRated = destination.rating != null && destination.rating! > 4.3;

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

String _getTimeSegment(int hour) {
  if (hour >= 0 && hour < 6) return "Dini Hari";
  if (hour >= 6 && hour < 11) return "Pagi";
  if (hour >= 11 && hour < 15) return "Siang";
  if (hour >= 15 && hour < 18) return "Sore";
  return "Malam";
}

Future<List<Destination>> getRecommendations({
  required String category,
  String? query,
  String? filter,
}) async {
  Position userPosition;

  try {
    userPosition = await getCurrentUserPosition();
  } catch (e) {
    debugPrint('Gagal mendapatkan lokasi pengguna: $e');
    return [];
  }

  List<Destination> destinations = await getDestinations();

  // kategori dan query
  destinations =
      destinations.where((destination) {
        final matchCategory =
            category == "All" || destination.category == category;
        final matchQuery =
            query == null ||
            query.isEmpty ||
            destination.name!.toLowerCase().contains(query.toLowerCase());
        return matchCategory && matchQuery;
      }).toList();

  // Hitung jarak ke user di tipe map
  final Map<Destination, double> distances = {};

  for (var dest in destinations) {
    double distance = _calculateDistance(
      userPosition.latitude,
      userPosition.longitude,
      dest.latitude,
      dest.longitude,
    );

    distances[dest] = distance;

    debugPrint(
      'Destinasi: ${dest.name}, Jarak: ${distance.toStringAsFixed(2)} km',
    );
  }

  // Filter lainnya
  if (filter == 'rating') {
    destinations.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
  } else if (filter == 'price') {
    destinations.sort((a, b) => a.budget.compareTo(b.budget));
  } else if (filter == 'alam') {
    destinations =
        destinations
            .where((d) => d.subCategories?.contains('Wisata Alam') ?? false)
            .toList();
  } else if (filter == 'kota') {
    destinations =
        destinations
            .where((d) => d.subCategories?.contains('Wisata Kota') ?? false)
            .toList();
  }

  // JARAK MAX
  final maxDistanceKm = 10.0;

  destinations =
      destinations
          .where((d) => (distances[d] ?? double.infinity) <= maxDistanceKm)
          .toList();

  // sorting jarak terdekat
  destinations.sort(
    (a, b) => (distances[a] ?? double.infinity).compareTo(
      distances[b] ?? double.infinity,
    ),
  );

  return destinations;
}
