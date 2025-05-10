import 'package:flutter/material.dart';
import 'package:forclient_travelapp/screens/splash.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class MainMaterial extends StatelessWidget {
  const MainMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogja Go',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      home: const SplashPage(),
    );
  }
}
