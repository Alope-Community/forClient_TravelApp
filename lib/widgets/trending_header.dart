import 'package:flutter/material.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class TrendingHeader extends StatelessWidget {
  const TrendingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Icon(
          Icons.local_fire_department_rounded,
          color: AppColors.danger,
          size: 30,
        ),
        Text(
          'Trending',
          style: AppTextStyles.heading2.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.danger,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
