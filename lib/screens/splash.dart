import 'package:flutter/material.dart';
import 'package:forclient_travelapp/screens/home.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-splash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              spacing: 20,
              children: [
                Text(
                  'Let\'s Enjoy The Beautiful City',
                  style: AppTextStyles.heading1,
                ),
                Text(
                  'Yogyakarta, kota budaya penuh pesona candi kuliner, dan suasana hangat menanti!',
                  style: AppTextStyles.heading2,
                ),
                SizedBox(height: 20),
                OutlinedButton(
                  onPressed:
                      () => {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()),
                        ),
                      },
                  style: AppButtonStyles.outlinedButtonPrimary,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Text('Jelajahi Sekarang!'),
                      Icon(Icons.arrow_forward_rounded, size: 24.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
