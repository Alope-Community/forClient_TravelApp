import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < imageList.length) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
        _currentPage++;
      } else {
        _currentPage = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  final List<String> imageList = [
    'assets/images/bank_indonesia.jpg',
    'assets/images/banner.jpg',
    'assets/images/pantai-selatan.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: imageList.length,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemBuilder: (_, index) {
                        return Image.asset(
                          imageList[index],
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                          color: Colors.black26,
                          colorBlendMode: BlendMode.darken,
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment(1, .1),
                      child: IconButton(
                        onPressed:
                            () => _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.fastLinearToSlowEaseIn,
                            ),
                        icon: Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(-1, .1),
                      child: IconButton(
                        onPressed:
                            () => _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.fastLinearToSlowEaseIn,
                            ),
                        icon: Icon(
                          Icons.keyboard_arrow_left_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Positioned(
                  left: 12,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                imageList.length,
                (index) => _buildIndicator(index),
              ),
            ),
          ),

          // === CONTENT ===
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card Utama
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'HEHA Ocean View',
                              style: AppTextStyles.heading2.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              spacing: 2,
                              children: [
                                Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.amber,
                                ),
                                Text(
                                  '9/10',
                                  style: AppTextStyles.small.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          spacing: 5,
                          children: const [
                            Icon(
                              Icons.location_on,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            Text(
                              'Kabupaten Gunungkidul, DI Yogyakarta',
                              style: AppTextStyles.small,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        const Text(
                          'HeHa Ocean View adalah tempat wisata di Gunungkidul, Yogyakarta, yang menyajikan pemandangan laut dari atas tebing dan spot foto Instagramable. Cocok untuk menikmati sunset dan bersantai.',
                          style: AppTextStyles.body,
                        ),
                        const SizedBox(height: 16),
                        const Text('Keunggulan', style: AppTextStyles.body),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildTag(Icons.local_parking, 'Parkir'),
                            _buildTag(Icons.family_restroom, 'Keluarga'),
                            _buildTag(Icons.attach_money, 'Menengah'),
                            _buildTag(Icons.camera_alt, 'Fotografi'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Review
                  const Text('Review', style: AppTextStyles.heading2),
                  const SizedBox(height: 12),
                  _buildReview(
                    name: 'Taufan Hidayatul Akbar',
                    rating: '9/10',
                    comment:
                        'HeHa Ocean View punya pemandangan laut yang indah dengan banyak spot foto estetik. Cocok buat santai.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.small.copyWith(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildReview({
    required String name,
    required String rating,
    required String comment,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            foregroundColor: Colors.white,
            backgroundColor: AppColors.secondary,
            child: Icon(Icons.person),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 2),
                        Text(
                          "9/10",
                          style: AppTextStyles.small.copyWith(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(comment, style: AppTextStyles.small),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index) {
    bool isActive = index == _currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: isActive ? 10 : 8.0,
      width: isActive ? 12 : 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.primary : Colors.grey.shade400,
        boxShadow:
            isActive
                ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: .50),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                  ),
                ]
                : [],
      ),
    );
  }
}
