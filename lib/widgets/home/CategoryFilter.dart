import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kategori',
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'kanit',
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 5),
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        backgroundColor: selected ? const Color(0xFFA6752E) : Colors.white,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: selected ? Colors.white : const Color(0xFFA6752E)),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: selected ? Colors.white : const Color(0xFFA6752E),
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : const Color(0xFFA6752E),
                ),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFA6752E)),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
