import 'package:flutter/material.dart';
import 'package:forclient_travelapp/services/destination.dart';
import 'package:forclient_travelapp/utils/constant.dart';
import 'package:forclient_travelapp/widgets/banner.dart';
import 'package:forclient_travelapp/widgets/bottom_navbar.dart';
import 'package:forclient_travelapp/widgets/list_category_chip.dart';
import 'package:forclient_travelapp/widgets/list_destination_preview.dart';
import 'package:forclient_travelapp/widgets/recomendation_header.dart';
import 'package:forclient_travelapp/widgets/trending_header.dart';
import 'package:forclient_travelapp/widgets/modal_bottom_filter.dart';

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
                        child: SearchBar(
                          controller: queryController,
                          onSubmitted: (value) {
                            setState(() {
                              queryController.text = value;
                            });
                          },
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          leading: Icon(Icons.search_rounded),
                          hintText: 'Cari Tempat Wisata',
                          hintStyle: WidgetStateProperty.all(
                            AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:
                            () => {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (context) {
                                  return ModalBottomFilter(
                                    selectedFilter: selectedFilter,
                                    onSelectedFilter: (filter) {
                                      setState(() {
                                        selectedFilter = filter;
                                      });
                                    },
                                  );
                                },
                              ),
                            },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: .2),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.tune,
                            color: AppColors.primary,
                          ),
                        ),
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
