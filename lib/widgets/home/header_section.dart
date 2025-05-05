import 'package:flutter/material.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class HeaderSection extends StatelessWidget {
  final String title;
  final String seeAll;
  final void Function()? onSeeAllPressed; 
  final void Function()? onTitlePressed;

  const HeaderSection({
    Key? key,
    this.onSeeAllPressed,
    this.onTitlePressed,
    required this.title,
    required this.seeAll,
  }) : super(key: key);

  
  
    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: title == "Recomendation" ? AppColors.success : AppColors.danger,
                ),
                const SizedBox(width: 2),
                GestureDetector(
                  onTap: () {
                    print('Title pressed');
                  },
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'kanit',
                      fontWeight: FontWeight.bold,
                      color: title == "Recomendation" ? AppColors.success : AppColors.danger,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
               GestureDetector(
                  onTap: () {
                    // Aksi ketika "See All" ditekan
                    // Misalnya, navigasi ke halaman lain atau tampilkan daftar lengkap
                    print('See All pressed');
                  },
                  child: Text(
                    seeAll,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: 'kanit',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(width: 4), // Jarak antara teks dan icon
                const Icon(
                  Icons.arrow_right_alt,
                  color: Colors.grey,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      );
    }

}