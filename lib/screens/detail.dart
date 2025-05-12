import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forclient_travelapp/models/destination.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class DetailPage extends StatefulWidget {
  final Destination destination;

  const DetailPage({required this.destination, super.key});

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
      if (_currentPage < widget.destination.images.length) {
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

  // final List<String> imageList = [
  //   'assets/images/banner-explore.jpg',
  //   'assets/images/banner-wishlist.jpg',
  //   'assets/images/banner-home.jpg',
  // ];

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
                      itemCount: widget.destination.images.length,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemBuilder: (_, index) {
                        return Stack(
                          children: [
                            Image.asset(
                              widget.destination.images[index],
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: double.infinity,
                              height: 300,
                              color: Colors.black.withValues(alpha: .2),
                            ),
                          ],
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
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.destination.images.length,
                (index) => _buildIndicator(index),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              widget.destination.name!,
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
                                  widget.destination.rating.toString(),
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
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            Text(
                              widget.destination.location,
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
