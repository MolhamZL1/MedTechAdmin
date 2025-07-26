import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/services/get_it_service.dart';
import 'package:med_tech_admin/core/widgets/AdaptiveLayout.dart';
import 'package:med_tech_admin/features/auth/domain/repos/auth_repo.dart';
import 'package:med_tech_admin/features/auth/presentation/cubits/auth/auth_cubit.dart';

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
