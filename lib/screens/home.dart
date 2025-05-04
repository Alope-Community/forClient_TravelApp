import 'package:flutter/material.dart';
import 'package:forclient_travelapp/widgets/home/HeaderSection.dart';
import 'package:forclient_travelapp/widgets/home/TrendingCard.dart';
import '../widgets/home/category_filter.dart';
import '../widgets/home/banner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SearchBanner(),
          SizedBox(height: 10),
          CategoryFilter(),
          HeaderSection(title: "Rekomendasi", seeAll: "see all"),
          SizedBox(height: 10),
          SizedBox(
            height:
                210, // Memberi tinggi tetap agar horizontal scroll bisa bekerja
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Trendingcard(
                  imageUrl: 'assets/images/pantai-selatan.jpg',
                  title: 'Pantai Selatan',
                  rating: '4.8',
                  kategori: 'Alam',
                  price: 'Rp.30.000 - Rp.50.000',
                ),
                Trendingcard(
                  imageUrl: 'assets/images/banner.jpg',
                  title: 'Malioboro',
                  rating: '4.7',
                  kategori: 'Perkotaan',
                  price: 'Rp.50.000 - Rp.100.000',
                ),
                Trendingcard(
                  imageUrl: 'assets/images/borubudur.jpg',
                  title: 'Candi Borobudur',
                  rating: '4.6',
                  kategori: 'Sejarah',
                  price: 'Rp.70.000 - Rp.100.000',
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          HeaderSection(seeAll: "see all", title: "Trending"),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
