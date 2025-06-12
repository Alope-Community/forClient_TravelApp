import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:forclient_travelapp/services/destination.dart';
import 'package:forclient_travelapp/widgets/banner.dart';
import 'package:forclient_travelapp/widgets/bottom_navbar.dart';
import 'package:forclient_travelapp/widgets/list_category_chip.dart';
import 'package:forclient_travelapp/widgets/list_destination_preview.dart';
import 'package:forclient_travelapp/widgets/recomendation_header.dart';
import 'package:forclient_travelapp/widgets/trending_header.dart';
import 'package:forclient_travelapp/widgets/search_field.dart';
import 'package:forclient_travelapp/widgets/filter_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';
  String selectedFilter = 'none';
  TextEditingController queryController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(currentIndex: 0),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
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
                    // userLatitude: position.latitude,
                    // userLongitude: position.longitude,
                  ),
                  isRecomendation: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
