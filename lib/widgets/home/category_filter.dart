import 'package:flutter/material.dart';
import 'package:forclient_travelapp/service/wisata_service.dart';
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
          const SizedBox(height: 12),
          FutureBuilder<List<String>>(
            future: getKategoriList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("Terjadi Kesalahan"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: Text('Tidak ada data')),
                );
              } else {
                final kategoriList = snapshot.data!;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: kategoriList.map((kategori) {
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
