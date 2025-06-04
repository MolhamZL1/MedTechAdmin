import 'package:flutter/material.dart';

import 'buildShadowText.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Image.asset(
              'assets/images/login.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildShadowText(context, 'مرحباً بكم'),
              buildShadowText(context, 'BitarMed'),
              buildShadowText(context, 'لبيع وتاجير وصيانة'),
              buildShadowText(context, 'الاجهزة الطبية'),
            ],
          ),
        ),
      ],
    );
  }
}
