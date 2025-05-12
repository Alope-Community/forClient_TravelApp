import 'package:flutter/material.dart';
import 'package:forclient_travelapp/screens/home.dart';
import 'package:forclient_travelapp/screens/wishlist.dart';
import 'package:forclient_travelapp/service/wisata_service.dart';
import 'package:forclient_travelapp/utils/constant.dart';
import 'package:forclient_travelapp/widgets/banner.dart';
import 'package:forclient_travelapp/widgets/list_item/card_widget.dart';

class ListWisata extends StatefulWidget {
  const ListWisata({Key? key}) : super(key: key);

  @override
  State<ListWisata> createState() => _ListWisataState();
}

class _ListWisataState extends State<ListWisata> {
  @override
  void initState() {
    super.initState();
    getWisata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SearchBanner(
            imageUrl: 'assets/images/banner2.jpg',
            title: 'Berikut List\nWisata',
            page: 'listWisata',
          ),
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            // padding: const EdgeInsets.symmetric(horizontal: ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: getWisata(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Terjadi Kesalahan"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: Text('Tidak ada data')),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final item = snapshot.data![index];
                          return CardWidget(
                            imageUrl: item.images[0].toString(),
                            title: item.nama.toString(),
                            rating: item.rating.toString(),
                            kategori: item.kategori.toString(),
                            price: item.budget.toString(),
                          );
                        },
                      );
                    } // Default return statement
                  },
                ),
              ],
            ),
          ),
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
        currentIndex: 1,
        selectedItemColor: AppColors.primary,
        onTap: (index) {
          if (index == 0) {
            // Home tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            // Explore tapped
          } else if (index == 2) {
            // Wishlist tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WishlistPage()),
            );
          }
        },
      ),
    );
    // Tulisan di tengah
  }
}
