import 'package:flutter/material.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class CategoryFilter extends StatefulWidget {
  final String initialCategory;
  final Function(String) onCategorySelected;

  const CategoryFilter({
    required this.initialCategory,
    required this.onCategorySelected,
    super.key,
  });

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
    widget.onCategorySelected(category);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kategori',
            style: TextStyle(
              fontSize: AppTextSizes.heading2,
              fontFamily: 'kanit',
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _CategoryChip(
                  icon: Icons.all_inclusive,
                  label: 'All',
                  selected: selectedCategory == 'All',
                  onTap: () => selectCategory('All'),
                ),
                const SizedBox(width: 10),
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
                _CategoryChip(
                  icon: Icons.theater_comedy,
                  label: 'Kesenian',
                  selected: selectedCategory == 'Kesenian',
                  onTap: () => selectCategory('Kesenian'),
                ),
                const SizedBox(width: 10),
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
