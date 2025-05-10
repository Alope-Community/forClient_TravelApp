import 'package:flutter/material.dart';
import 'package:forclient_travelapp/services/destination.dart';
import 'package:forclient_travelapp/utils/constant.dart';
import 'package:forclient_travelapp/widgets/banner.dart';
import 'package:forclient_travelapp/widgets/bottom_navbar.dart';
import 'package:forclient_travelapp/widgets/horizontal_card.dart';
import 'package:forclient_travelapp/screens/detail.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(currentIndex: 1),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          BannerHeader(
            imageUrl: 'assets/images/banner-explore.jpg',
            title: 'Daftar\nWisata',
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FutureBuilder(
              future: getDestinations(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: Text("Terjadi Kesalahan 😓")),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: Text('Tidak ada data 😔')),
                  );
                } else {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
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
