import 'package:flutter/material.dart';
import 'package:forclient_travelapp/widgets/search_input.dart';

class SearchBanner extends StatelessWidget {
  String imageUrl;
  String title;
  String page;

  SearchBanner({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Gambar background
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0x4C000000),
                blurRadius: 15,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              color: Colors.black45,
              colorBlendMode: BlendMode.darken,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Tulisan di tengah
        Positioned.fill(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
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
