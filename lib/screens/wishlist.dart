import 'package:flutter/material.dart';
import 'package:forclient_travelapp/models/destination.dart';
import 'package:forclient_travelapp/services/destination.dart';
import 'package:forclient_travelapp/widgets/banner.dart';
import 'package:forclient_travelapp/widgets/bottom_navbar.dart';
import 'package:forclient_travelapp/widgets/wishlist_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late List<Destination> wishlistItems = [];

  @override
  void initState() {
    super.initState();
    _loadWishlist();
  }

  void _loadWishlist() async {
    List<Destination> allDestinations = await getDestinations();
    setState(() {
      wishlistItems.addAll(allDestinations.take(5));
    });
  }

  void removeItem(int index) {
    setState(() {
      wishlistItems.removeAt(index);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Item dihapus dari wishlist')));
  }

  @override
  Widget build(BuildContext context) {
    var wishlistItems2 = wishlistItems;
    return Scaffold(
      bottomNavigationBar: BottomNavbar(currentIndex: 2),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          if (wishlistItems.isNotEmpty)
            const BannerHeader(
              title: "Kapan Mau Diwujudkan\nWishlist Kamu?",
              imageUrl: "assets/images/banner-wishlist.jpg",
            ),
          if (wishlistItems.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Belum ada wishlist 😔',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children:
                    wishlistItems
                        .asMap()
                        .entries
                        .map(
                          (entry) => WishlistCard(
                            item: entry.value,
                            onRemove: () => removeItem(entry.key),
                          ),
                        )
                        .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
