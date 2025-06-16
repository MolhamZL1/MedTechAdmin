import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/main/presentation/views/main_view.dart';

import '../../../../../core/functions/error_dialog.dart';
import '../../../../../core/widgets/CustomCircleLoading.dart';
import '../../cubits/cubit/auth_cubit.dart';

class SignInBlocConsumer extends StatelessWidget {
  const SignInBlocConsumer({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showWebErrorToast(context, state.errMessage);
        } else if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, MainView.routeName);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return CustomCircleLoading();
        } else {
          return SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(onPressed: onPressed, child: Text("Sign In")),
          );
        }
      },
    );
  }
}
