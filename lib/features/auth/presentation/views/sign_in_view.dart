import 'package:flutter/material.dart';

import '../../../../core/widgets/AdaptiveLayout.dart';
import 'widgets/SigninviewBody.dart';
import 'widgets/signInViewBodyMobile.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  static const String routeName = '/signin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveLayout(
        mobileLayout: (context) => SigninviewBodyMobile(),
        desktopLayout: (context) => SigninviewBody(),
        tabletLayout: (context) => SigninviewBodyMobile(),
      ),
    );
  }
}
