import 'package:flutter/material.dart';

class Trendingcard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String rating;
  final String kategori;
  final String price;
  final Function()? onTap;

  const Trendingcard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.kategori,
    required this.rating,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: onTap ?? () {
        // Default action if onTap is not provided
        print('Card tapped! ${title}');
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(left: 16, right: 8,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.asset(
                imageUrl,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'kanit',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Color(0xFFA6752E), size: 16),
                      const SizedBox(width: 4),
                      Text(rating),
                      const SizedBox(width: 8),
                      const Icon(Icons.category, color: Color(0xFFA6752E), size: 16),
                      const SizedBox(width: 4),
                      Text(kategori),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'kanit',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFA6752E),
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
