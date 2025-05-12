import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:forclient_travelapp/model/wisata.dart';

Future<List<Wisata>> getWisata() async {
  final String response = await rootBundle.loadString('assets/data/wisata.json');
  final data = await json.decode(response);
  List<Wisata> wisataList = (data as List).map((i) => Wisata.fromJson(i)).toList();
  return wisataList;
}

Future<List<Wisata>> getRecomendation({required String kategori}) async {
  DateTime dateTime = DateTime.now();
  int hour = dateTime.hour;
  String waktu;

   if (hour >= 0 && hour < 6) {
      waktu = "Dini Hari";
    } else if (hour >= 6 && hour < 11) {
      waktu = "Pagi";
    } else if (hour >= 11 && hour < 15) {
      waktu = "Siang";
    } else if (hour >= 15 && hour < 18) {
      waktu = "Sore";
    } else {
      waktu = "Malam";
    }

  final String response = await rootBundle.loadString('assets/data/wisata.json');
  final data = await json.decode(response);
  List<Wisata> wisataList = (data as List).map((i) => Wisata.fromJson(i)).toList();
  List<Wisata>? recomendation = wisataList.where((w) { 
    if(kategori != "All"){
      return w.kategori == kategori && (w.waktuKunjungan?[waktu] ?? 0) > 0.5;
    } else {
       return (w.waktuKunjungan?[waktu] ?? 0) > 0.5;
    }
  }).toList();

  // debugPrint(recomendation.toString());

  return recomendation; 
}

Future<List<Wisata>> getTrending({required String kategori}) async {
  final String response = await rootBundle.loadString('assets/data/wisata.json');
  final data = await json.decode(response);
  List<Wisata>? wisataList = (data as List).map((i) => Wisata.fromJson(i)).toList();

  List<Wisata>? tredingItem = wisataList.where((w){
    if (kategori != "All") {
       return w.kategori == kategori && w.rating != null && w.rating! > 4.3;
    } else {
      return w.rating != null && w.rating! > 4.3;
    }
  }).toList();


  return tredingItem;
}