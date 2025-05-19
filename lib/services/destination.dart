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

Future<List<Destination>> getRecommendations({
  required String category,
  String? query,
  String? filter,
}) async {
  List<Destination> destinations = await getDestinations();
  final currentHour = DateTime.now().hour;
  final timeSegment = _getTimeSegment(currentHour);

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
    final suitability = destination.visitingTime?[timeSegment] ?? 0;

    final matchCategory = category == "All" || destination.category == category;

    final matchQuery =
        query == null ||
        query.isEmpty ||
        destination.name!.toLowerCase().contains(query.toLowerCase());

    return suitability > 0.5 && matchCategory && matchQuery;
  }).toList();
}

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

String _getTimeSegment(int hour) {
  if (hour >= 0 && hour < 6) return "Dini Hari";
  if (hour >= 6 && hour < 11) return "Pagi";
  if (hour >= 11 && hour < 15) return "Siang";
  if (hour >= 15 && hour < 18) return "Sore";
  return "Malam";
}
