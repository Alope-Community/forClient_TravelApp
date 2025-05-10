import 'package:flutter/material.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class BannerHeader extends StatelessWidget {
  final String imageUrl;
  final String title;
  final TextStyle? titleStyle;

  const BannerHeader({
    super.key,
    required this.imageUrl,
    required this.title,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
            child: Stack(
              children: [
                Image.asset(
                  imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  color: Colors.black.withValues(
                    alpha: .5,
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned.fill(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style:
                  titleStyle ??
                  AppTextStyles.heading1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
