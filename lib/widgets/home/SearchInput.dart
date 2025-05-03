import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Urutkan berdasarkan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Rating Tertinggi'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Terdekat'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: const Text('Baru Ditambahkan'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFA6752E)),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  icon: Icon(Icons.search, color: Color(0xFFA6752E)),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => _showSortOptions(context),
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFA6752E)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.tune, color: Color(0xFFA6752E)),
          ),
        ),
      ],
    );
  }
}
