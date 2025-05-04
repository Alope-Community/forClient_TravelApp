import 'package:flutter/material.dart';
import '../widgets/home/category_filter.dart';
import '../widgets/home/banner.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          SearchBanner(),
          SizedBox(height: 16),
          CategoryFilter(),
        ],
      ),
    );
  }
}
