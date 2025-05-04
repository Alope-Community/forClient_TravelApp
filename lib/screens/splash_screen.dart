import 'package:flutter/material.dart';
import 'package:forclient_travelapp/screens/home.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bank_indonesia.jpg'),
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
                ElevatedButton(
                  onPressed:
                      () => {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()),
                        ),
                      },
                  style: AppButtonStyles.elevatedButtonPrimary,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Text('Jelajahi Sekarang!'),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 24.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
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
