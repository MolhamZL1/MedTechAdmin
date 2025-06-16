import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/services/get_it_service.dart';
import 'package:med_tech_admin/features/auth/domain/repos/auth_repo.dart';
import 'package:med_tech_admin/features/auth/presentation/cubits/cubit/auth_cubit.dart';

import 'widgets/SigninviewBody.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  static const String routeName = '/signin';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt.get<AuthRepo>()),
      child: Scaffold(body: SigninviewBody()),
    );
  }
}
