import 'package:flutter/material.dart';
import 'package:forclient_travelapp/screens/list_wisata.dart';
import 'package:forclient_travelapp/screens/wishlist.dart';
import 'package:forclient_travelapp/service/wisata_service.dart';
import 'package:forclient_travelapp/utils/constant.dart';
import 'package:forclient_travelapp/widgets/home/header_section.dart';
import 'package:forclient_travelapp/widgets/home/recomendation_card.dart';
import 'package:forclient_travelapp/widgets/home/trending_card.dart';
import '../widgets/home/category_filter.dart';
import '../widgets/banner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getRecomendation(kategori: "All");
    getTrending(kategori: "all");
  }

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
            child: ListView(scrollDirection: Axis.horizontal, children: [
                
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
          FutureBuilder(
            future: getRecomendation(kategori: 'All'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Terjadi kesalahan'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('Tidak ada data'));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return RecomendationCard(
                      imageUrl: 'assets/images/borubudur.jpg',
                      title: item.name ?? '',
                      rating: item.rating?.toString() ?? '',
                      kategori: item.kategori ?? '',
                      price: item.budjet?.toString() ?? '',
                    );
                  },
                );
              }
            },
          ),
          SizedBox(height: 1),
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
