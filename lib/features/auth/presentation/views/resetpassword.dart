import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../domain/repos/auth_repo.dart';
import '../cubits/resetpassword/resetpassword_cubit.dart';
import 'widgets/ResetPasswordViewBody.dart';

class ResetpasswordView extends StatelessWidget {
  const ResetpasswordView({super.key});

  static const routeName = '/resetpassword';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetpasswordCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Reset Password')),
        body: ResetPasswordViewBody(),
      ),
    );
  }
}
