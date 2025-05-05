import 'package:flutter/material.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class RecomendationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String rating;
  final String kategori;
  final String price;
  final Function()? onTap;

  const RecomendationCard({
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
      onDoubleTap: onTap,
      child: Container(
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: Image.asset(
                imageUrl,
                width: 150,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 17,
                          fontFamily: 'kanit',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          spacing: 3,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.primary,
                              size: 15,
                            ),
                            Text(
                              rating,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontFamily: 'kanit',
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.money_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        price,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontFamily: 'kanit',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.category, color: AppColors.primary, size: 20),
                      SizedBox(width: 10,),
                      Text(
                        kategori,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontFamily: 'kanit',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
