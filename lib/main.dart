import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/functions/on_generate_route.dart';
import 'package:med_tech_admin/core/services/custom_bloc_observer.dart';
import 'package:med_tech_admin/core/services/get_it_service.dart';
import 'package:med_tech_admin/core/utils/App_themes.dart';
import 'package:med_tech_admin/features/main/presentation/views/main_view.dart';

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

      home: const MainView(),
    );
  }
}
