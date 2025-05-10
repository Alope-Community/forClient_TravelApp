import 'package:flutter/material.dart';
import 'package:forclient_travelapp/services/destination.dart';
import 'package:forclient_travelapp/utils/constant.dart';
import 'package:forclient_travelapp/widgets/banner.dart';
import 'package:forclient_travelapp/widgets/bottom_navbar.dart';
import 'package:forclient_travelapp/widgets/horizontal_card.dart';
import 'package:forclient_travelapp/screens/detail.dart';
import 'package:forclient_travelapp/widgets/search_field.dart';
import 'package:forclient_travelapp/widgets/filter_button.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String selectedFilter = 'none';
  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(currentIndex: 1),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              BannerHeader(
                imageUrl: 'assets/images/banner-explore.jpg',
                title: 'Daftar\nWisata',
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
                        onSelectedFilter: (value) {
                          setState(() {
                            selectedFilter = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FutureBuilder(
              future: getDestinations(
                query: queryController.text,
                filter: selectedFilter,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: AppColors.primary,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        "Terjadi Kesalahan 😓",
                        style: AppTextStyles.small,
                      ),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return SizedBox(
                    height: 220,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          'Tidak ada data 😔',
                          style: AppTextStyles.heading3,
                        ),
                      ),
                    ),
                  );
                } else {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 15),
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => DetailPage(destination: item),
                            ),
                          );
                        },
                        child: HorizontalCard(
                          imageUrl: item.images[0].toString(),
                          title: item.name.toString(),
                          rating: item.rating.toString(),
                          category: item.category.toString(),
                          price: item.budget.toString(),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
