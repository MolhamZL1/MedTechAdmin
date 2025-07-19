import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/forget_password_view.dart';
import '../../features/auth/presentation/views/resetpassword.dart';
import '../../features/auth/presentation/views/sign_in_view.dart';
import '../../features/main/presentation/views/main_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case SplashView.routeName:
    //   return MaterialPageRoute(builder: (context) => const SplashView());
    case SignInView.routeName:
      return MaterialPageRoute(builder: (context) => const SignInView());
    case ForgetPasswordView.routeName:
      return MaterialPageRoute(
        builder: (context) => const ForgetPasswordView(),
      );
    case ResetpasswordView.routeName:
      return MaterialPageRoute(builder: (context) => const ResetpasswordView());
    case MainView.routeName:
      return MaterialPageRoute(builder: (context) => const MainView());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
