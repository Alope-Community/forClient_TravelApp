import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:forclient_travelapp/model/Wisata.dart';

Future<List<Wisata>> getWisata() async {
  final String response = await rootBundle.loadString('assets/wisata.json');
  final data = await json.decode(response);
  List<Wisata> wisataList = (data as List).map((i) => Wisata.fromJson(i)).toList();
  return wisataList;
}