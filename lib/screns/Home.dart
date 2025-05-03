import 'package:flutter/material.dart';
import 'package:forclient_travelapp/widgets/home/CategoryFilter.dart';
import 'package:forclient_travelapp/widgets/home/SearchBanner.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          SearchBanner(),
          SizedBox(height: 16), // Jarak antara banner dan kategori
          CategoryFilter(),
          // Tambahkan komponen lainnya di bawah sini
        ],
      ),
    );
  }
}
