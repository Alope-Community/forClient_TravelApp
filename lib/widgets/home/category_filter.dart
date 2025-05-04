import 'package:flutter/material.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class CategoryFilter extends StatefulWidget {
  const CategoryFilter({super.key});

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  String selectedCategory = 'Perkotaan';

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Kategori', style: AppTextStyles.heading2),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _CategoryChip(
                  icon: Icons.location_city,
                  label: 'Perkotaan',
                  selected: selectedCategory == 'Perkotaan',
                  onTap: () => selectCategory('Perkotaan'),
                ),
                const SizedBox(width: 10),
                _CategoryChip(
                  icon: Icons.park,
                  label: 'Alam',
                  selected: selectedCategory == 'Alam',
                  onTap: () => selectCategory('Alam'),
                ),
                const SizedBox(width: 10),
                _CategoryChip(
                  icon: Icons.restaurant,
                  label: 'Kuliner',
                  selected: selectedCategory == 'Kuliner',
                  onTap: () => selectCategory('Kuliner'),
                ),
                const SizedBox(width: 10),
                // Tambahkan kategori lainnya jika perlu
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        backgroundColor: selected ? AppColors.primary : Colors.white,
        label: Row(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: selected ? Colors.white : AppColors.primary),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: selected ? Colors.white : AppColors.primary,
                    width: 2,
                  ),
                ),
              ),
            ),
            Text(
              label,
              style: AppTextStyles.small.copyWith(
                color: selected ? Colors.white : AppColors.primary,
              ),
            ),
          ],
        ),
        shape: StadiumBorder(
          side: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
