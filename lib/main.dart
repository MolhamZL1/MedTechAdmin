import 'package:flutter/material.dart';
<<<<<<< HEAD

import 'features/auth/presentation/views/widgets/sign_in_view_body.dart';
=======
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/functions/on_generate_route.dart';
import 'package:med_tech_admin/core/services/custom_bloc_observer.dart';
import 'package:med_tech_admin/core/services/get_it_service.dart';
import 'package:med_tech_admin/core/utils/App_themes.dart';
import 'package:med_tech_admin/features/main/presentation/views/main_view.dart';
>>>>>>> 9ca4f5fde8a42ab123b268c3a188ea02836264e0

void main() {
  Bloc.observer = CustomBlocObserver();
  setupSingltonGetIt();
  runApp(const MedTech());
}

class MedTech extends StatelessWidget {
  const MedTech({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BitarMed",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      onGenerateRoute: (settings) => onGenerateRoute(settings),
      //  initialRoute: SignInView.routeName,
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
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
=======

      home: const MainView(),
>>>>>>> 9ca4f5fde8a42ab123b268c3a188ea02836264e0
    );
  }
}
