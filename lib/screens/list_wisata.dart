import 'package:flutter/material.dart';
import 'package:forclient_travelapp/screens/home.dart';
import 'package:forclient_travelapp/screens/wishlist.dart';
import 'package:forclient_travelapp/utils/constant.dart';
import 'package:forclient_travelapp/widgets/banner.dart';
import 'package:forclient_travelapp/widgets/list_item/card_widget.dart';

class ListWisata extends StatelessWidget {
  const ListWisata({Key? key}) : super(key: key);

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
                for (int i = 1; i <= 4; i++)
                  CardWidget(
                    imageUrl: 'assets/images/pantai-selatan.jpg',
                    title: 'Pantai Selatan',
                    kategori: 'Alam',
                    rating: '4.8',
                    price: 'Rp.30.000 - Rp.50.000',
                    onTap: () {
                      // Aksi saat card di-tap
                      print('Card $i tapped!');
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
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
