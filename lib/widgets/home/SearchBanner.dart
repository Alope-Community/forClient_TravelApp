import 'package:flutter/material.dart';
import 'package:forclient_travelapp/widgets/home/SearchInput.dart';

class SearchBanner extends StatelessWidget {
  const SearchBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Gambar background
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          child: Image.asset(
            'assets/malioboro.jpg',
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
        ),

        // Tulisan di tengah
        Positioned.fill(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Kemana Kamu\nIngin Pergi?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'kanit',
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ),

        // Search input mengambang
        const Positioned(
          bottom: -25, // Atur posisi supaya menjorok ke bawah dari image
          left: 24,
          right: 24,
          child: SearchInput(),
        ),
      ],
    );
  }
}
