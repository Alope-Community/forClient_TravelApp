import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:forclient_travelapp/screens/list_wisata.dart';
import 'package:forclient_travelapp/screens/wishlist.dart';
import 'package:forclient_travelapp/service/wisata_service.dart';
import 'package:forclient_travelapp/utils/constant.dart';
import 'package:forclient_travelapp/widgets/home/header_section.dart';
import 'package:forclient_travelapp/widgets/home/recomendation_card.dart';
import 'package:forclient_travelapp/widgets/home/trending_card.dart';
import '../widgets/home/category_filter.dart';
import '../widgets/banner.dart';
=======
import 'package:forclient_travelapp/services/destination.dart';
import 'package:forclient_travelapp/widgets/banner.dart';
import 'package:forclient_travelapp/widgets/bottom_navbar.dart';
import 'package:forclient_travelapp/widgets/list_category_chip.dart';
import 'package:forclient_travelapp/widgets/list_destination_preview.dart';
import 'package:forclient_travelapp/widgets/recomendation_header.dart';
import 'package:forclient_travelapp/widgets/trending_header.dart';
import 'package:forclient_travelapp/widgets/search_field.dart';
import 'package:forclient_travelapp/widgets/filter_button.dart';
>>>>>>> 7020aacdfa8c9d4c1b8b8509939c44fd76f94313

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';
<<<<<<< HEAD

  @override
  void initState() {
    super.initState();
    getRecomendation(kategori: "All");
    getTrending(kategori: "All");
  }
=======
  String selectedFilter = 'none';
  TextEditingController queryController = TextEditingController();
>>>>>>> 7020aacdfa8c9d4c1b8b8509939c44fd76f94313

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(currentIndex: 0),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
<<<<<<< HEAD
          SearchBanner(
            imageUrl: 'assets/images/banner.jpg',
            title: 'Kemana Kamu\nIngin Pergi?',
            titleSize: 35,
            page: 'home',
=======
          Stack(
            clipBehavior: Clip.none,
            children: [
              BannerHeader(
                imageUrl: 'assets/images/banner-home.jpg',
                title: 'Kemana Kamu\nIngin Pergi?',
              ),

              Positioned(
                bottom: -25,
                left: 16,
                right: 16,
                child: SizedBox(
                  height: 50,
                  child: Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: SearchField(
                          queryController: queryController,
                          onChanged: (value) {
                            setState(() {
                              queryController.text = value;
                            });
                          },
                          onSubmitted: (value) {
                            setState(() {
                              queryController.text = value;
                            });
                          },
                          onReset: () {
                            setState(() {
                              queryController.text = '';
                            });
                          },
                        ),
                      ),
                      FilterButton(
                        selectedFilter: selectedFilter,
                        onSelectedFilter: (filter) {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
>>>>>>> 7020aacdfa8c9d4c1b8b8509939c44fd76f94313
          ),

          SizedBox(height: 40),

          CategoryFilter(
            initialCategory: selectedCategory,
            onCategorySelected: (newCategory) {
              setState(() {
                selectedCategory = newCategory;
              });
            },
          ),
<<<<<<< HEAD
          HeaderSection(title: "Trending", seeAll: "see all"),
          SizedBox(height: 10),
          FutureBuilder(
            future: getTrending(kategori: selectedCategory),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("Terjadi Kesalahan"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: Text('Tidak ada data')),
                );
              } else {
                return SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return Trendingcard(
                        imageUrl: item.images[0].toString(),
                        title: item.nama.toString(),
                        rating: item.rating.toString(),
                        kategori: item.kategori.toString(),
                        price: item.budget.toString(),
                      );
                    },
=======

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                TrendingHeader(),
                ListDestinationPreview(
                  selectedCategory: selectedCategory,
                  future: getTrendingDestinations(
                    category: selectedCategory,
                    query: queryController.text,
                    filter: selectedFilter,
>>>>>>> 7020aacdfa8c9d4c1b8b8509939c44fd76f94313
                  ),
                  isRecomendation: false,
                ),
                RecomendationHeader(),
                ListDestinationPreview(
                  selectedCategory: selectedCategory,
                  future: getRecommendations(
                    category: selectedCategory,
                    query: queryController.text,
                    filter: selectedFilter,
                  ),
<<<<<<< HEAD
                },
          ),
          SizedBox(height: 10),
          FutureBuilder(
            future: getRecomendation(kategori: selectedCategory),
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
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return RecomendationCard(
                      imageUrl: item.images[0].toString(),
                      title: item.nama.toString(),
                      rating: item.rating.toString(),
                      kategori: item.kategori.toString(),
                      price: item.budget.toString(),
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
            label: 'Wistlist',
=======
                  isRecomendation: true,
                ),
              ],
            ),
>>>>>>> 7020aacdfa8c9d4c1b8b8509939c44fd76f94313
          ),
        ],
      ),
    );
  }
}
