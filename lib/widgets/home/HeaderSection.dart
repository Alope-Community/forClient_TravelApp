import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String title;
  final String seeAll;
  final Color? color; // Warna teks judul
  final Color? seeAllColor; // Warna teks "See All"
  final void Function()? onSeeAllPressed; 
  final void Function()? onTitlePressed;

  const HeaderSection({
    Key? key,
    this.onSeeAllPressed,
    this.onTitlePressed,
    required this.title,
    required this.seeAll,
    this.color,
    this.seeAllColor,
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
                const Icon(
                  Icons.local_fire_department,
                  color: Colors.redAccent,
                ),
                const SizedBox(width: 2), // Jarak antara icon dan teks
                GestureDetector(
                  onTap: () {
                    print('Title pressed');
                  },
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'kanit',
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
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