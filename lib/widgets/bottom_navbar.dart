// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:forclient_travelapp/screens/explore.dart';
import 'package:forclient_travelapp/screens/home.dart';
import 'package:forclient_travelapp/screens/wishlist.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;

  const BottomNavbar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedLabelStyle: AppTextStyles.small.copyWith(
        color: AppColors.primary,
      ),
      unselectedLabelStyle: AppTextStyles.small,
      onTap: (index) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              if (index == 0)
                return const HomePage();
              else if (index == 1)
                return const ExplorePage();
              else
                return WishlistPage();
            },
          ),
        );
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_rounded),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_rounded),
          label: 'Wishlist',
        ),
      ],
    );
  }
}
