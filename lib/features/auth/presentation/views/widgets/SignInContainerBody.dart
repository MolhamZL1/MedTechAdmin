import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/functions/custom_validator.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import 'package:med_tech_admin/features/auth/presentation/cubits/cubit/auth_cubit.dart';
import 'CustomPasswordTextField.dart';
import 'SignInBlocConsumer.dart';

class SignInContainerBody extends StatefulWidget {
  const SignInContainerBody({super.key});

  @override
  State<SignInContainerBody> createState() => _SignInContainerBodyState();
}

class _SignInContainerBodyState extends State<SignInContainerBody> {
  late String email;
  late String password;

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 30),
          Text(
            "Sign In",
            style: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(color: AppColors.primary),
          ),
          TextFormField(
            onSaved: (newValue) {
              email = newValue!;
            },
            autovalidateMode: autovalidateMode,
            validator: CustomValidator.emailValidator,
            decoration: InputDecoration(
              labelText: "Email",
              suffixIcon: Icon(Icons.email_outlined),
            ),
          ),
          CustomPasswordTextField(
            autovalidateMode: autovalidateMode,
            onSaved: (newValue) {
              password = newValue!;
            },
          ),
          SignInBlocConsumer(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                context.read<AuthCubit>().signin(
                  email: email,
                  password: password,
                );
              } else {
                autovalidateMode = AutovalidateMode.always;
              }
            },
          ),
        ],
      ),
    );
  }
}
