import 'package:flutter/material.dart';
import 'package:forclient_travelapp/screens/home.dart';
import 'package:forclient_travelapp/screens/list_wisata.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final List<Map<String, dynamic>> wishlistItems = [
    {
      'key': 'heha-ocean-view',
      'image': 'assets/images/banner.jpg',
      'title': 'HEHA Ocean View',
      'location': 'Gunungkidul, Yogyakarta',
      'rating': 9.2,
    },
    {
      'key': 'pantai-selatan-yogyakarta',
      'image': 'assets/images/banner.jpg',
      'title': 'Pantai Selatan',
      'location': 'Bantul, Yogyakarta',
      'rating': 8.7,
    },
  ];

  @override
  Widget build(BuildContext context) {
    var wishlistItems2 = wishlistItems;
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          wishlistItems2.isEmpty
              ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Belum ada wishlist 😔',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: wishlistItems2.length,
                itemBuilder: (context, index) {
                  final item = wishlistItems[index];
                  return Dismissible(
                    background: Container(
                      color: Colors.redAccent,
                      margin: EdgeInsets.only(bottom: 16),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    key: Key(item['key']),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        bool dismiss = false;
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Yakin Ingin Hapus Data Wishlist",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    dismiss = true;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Delete Item')),
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ya"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    dismiss = false;
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Tidak"),
                                ),
                              ],
                            );
                          },
                        );
                        if (dismiss) {
                          setState(() {
                            wishlistItems.removeAt(index);
                          });
                        }
                      }
                    },
                    onResize: () {
                      print("Resized");
                    },
                    resizeDuration: Duration(seconds: 5),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        onTap: () {
                          // TODO: navigate to detail
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                              child: Image.asset(
                                item['image'],
                                width: 120,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'],
                                      style: AppTextStyles.heading2.copyWith(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 14,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            item['location'],
                                            style: AppTextStyles.small,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      wishlistItems.removeAt(index);
                                    });
                                  },
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      item['rating'].toString(),
                                      style: AppTextStyles.small.copyWith(
                                        color: Colors.amber,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
        currentIndex: 2,
        selectedItemColor: AppColors.primary,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListWisata()),
            );
          } else if (index == 2) {
            // Wishlist tapped
          }
        },
      ),
    );
  }
}
