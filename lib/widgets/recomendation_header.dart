import 'package:flutter/material.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class RecomendationHeader extends StatelessWidget {
  const RecomendationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Icon(
          Icons.recommend_rounded,
          color: AppColors.success,
          size: 30,
        ),
        Text(
          'Rekomendasi',
          style: AppTextStyles.heading2.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.success,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
