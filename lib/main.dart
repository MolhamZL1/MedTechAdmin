import 'package:flutter/material.dart';

import 'features/auth/presentation/views/widgets/sign_in_view_body.dart';

void main() {
  runApp(const MedTech());
}

class MedTech extends StatelessWidget {
  const MedTech({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BitarMed',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          secondary:  Color(0xff0A9F68),
          primary:  Color(0xFF022015),
          seedColor:  Color(0xFF09AF72),
          tertiary:  Color(0xFF6C9E8C),
          background: Colors.white,
        ),
        useMaterial3: true,
        fontFamily: 'Tajawal',
        appBarTheme: const AppBarTheme(
          backgroundColor:Color(0xFF022015),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xff0A9F68)),
          titleTextStyle: TextStyle(
            color: Color(0xFF022015),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tajawal',
          ),
        ),
      ),
      home: const SignInView(),
      locale: const Locale('ar', 'SA'),
    );
  }

}

