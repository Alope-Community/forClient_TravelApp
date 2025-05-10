import 'package:flutter/material.dart';
import 'package:forclient_travelapp/services/destination.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<List<String>>(
            future: getCategoryList(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Terjadi Kesalahan 😓",
                    style: AppTextStyles.small,
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text(
                      'Tidak ada data 😔',
                      style: AppTextStyles.small,
                    ),
                  ),
                );
              } else {
                final kategoriList = snapshot.data!;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        kategoriList.map((kategori) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _CategoryChip(
                              label: kategori,
                              selected: selectedCategory == kategori,
                              onTap: () => selectCategory(kategori),
                            ),
                          );
                        }).toList(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
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
        label: Text(
          label,
          style: AppTextStyles.small.copyWith(
            color: selected ? Colors.white : AppColors.primary,
          ),
        ),
        shape: StadiumBorder(
          side: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
