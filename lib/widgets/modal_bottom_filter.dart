import 'package:flutter/material.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class ModalBottomFilter extends StatelessWidget {
  final String selectedFilter;
  final void Function(String) onSelectedFilter;

  const ModalBottomFilter({
    required this.selectedFilter,
    required this.onSelectedFilter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Urutkan berdasarkan', style: AppTextStyles.heading2),
          const SizedBox(height: 12),
          _buildFilterTile(
            context,
            icon: Icons.star,
            label: 'Rating Tertinggi',
            filter: 'rating',
          ),
          _buildFilterTile(
            context,
            icon: Icons.trending_down_rounded,
            label: 'Harga Terjangkau',
            filter: 'price',
          ),
          _buildFilterTile(
            context,
            icon: Icons.location_city,
            label: 'Wisata Kota',
            filter: 'kota',
          ),
          _buildFilterTile(
            context,
            icon: Icons.terrain,
            label: 'Wisata Alam',
            filter: 'alam',
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String filter,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      selected: selectedFilter == filter,
      selectedTileColor: AppColors.secondary,
      selectedColor: Colors.white,
      leading: Icon(icon),
      title: Text(
        label,
        style: AppTextStyles.body.copyWith(
          color: selectedFilter == filter ? Colors.white : AppColors.primary,
        ),
      ),
      onTap: () {
        onSelectedFilter(filter);
        Navigator.pop(context);
      },
    );
  }
}
