import 'package:flutter/material.dart';
import 'package:forclient_travelapp/screens/list_wisata.dart';
import 'package:forclient_travelapp/screens/wishlist.dart';
import 'package:forclient_travelapp/utils/constant.dart';
import 'package:forclient_travelapp/widgets/home/header_section.dart';
import 'package:forclient_travelapp/widgets/home/recomendation_card.dart';
import 'package:forclient_travelapp/widgets/home/trending_card.dart';
import '../widgets/home/category_filter.dart';
import '../widgets/banner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SearchBanner(
            imageUrl: 'assets/images/banner.jpg',
            title: 'Kemana Kamu\nIngin Pergi?',
            page: 'home',
          ),
          SizedBox(height: 10),
          CategoryFilter(),
          HeaderSection(title: "Trending", seeAll: "see all"),
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
          HeaderSection(
            seeAll: "see all",
            title: "Recomendation",
            onSeeAllPressed:
                () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListWisata()),
                  ),
                },
          ),
          SizedBox(height: 10),
          RecomendationCard(
            imageUrl: 'assets/images/borubudur.jpg',
            title: 'Candi Borobudur',
            rating: '4.6',
            kategori: 'Sejarah',
            price: 'Rp.70.000 - Rp.100.000',
          ),
          RecomendationCard(
            imageUrl: 'assets/images/borubudur.jpg',
            title: 'Candi Borobudur',
            rating: '4.6',
            kategori: 'Sejarah',
            price: 'Rp.70.000 - Rp.100.000',
          ),
          RecomendationCard(
            imageUrl: 'assets/images/borubudur.jpg',
            title: 'Candi Borobudur',
            rating: '4.6',
            kategori: 'Sejarah',
            price: 'Rp.70.000 - Rp.100.000',
          ),
          // SizedBox(height: 1,)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Whishlist',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: AppColors.primary,
        onTap: (index) {
          if (index == 0) {
            // Explro Tapped
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListWisata()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WishlistPage()),
            );
          }
        },
      ),
    );
    return scaffold;
  }
}
