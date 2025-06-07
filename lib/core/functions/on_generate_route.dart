import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/sign_in_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case SplashView.routeName:
    //   return MaterialPageRoute(builder: (context) => const SplashView());
    case SignInView.routeName:
      return MaterialPageRoute(builder: (context) => const SignInView());
    // case MainView.routeName:
    //   return MaterialPageRoute(builder: (context) => const MainView());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
