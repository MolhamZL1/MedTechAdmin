import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/auth/presentation/views/widgets/buildShadowText.dart';

import 'ElevatedButtonForSignIn.dart';
import 'TextFieldFormForEmail.dart';
import 'TextFieldFormForPassword.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildShadowText(context, "تسجيل الدخول"),
           SizedBox(height: 20),
          TextFieldFormForEmail(),
          const SizedBox(height: 16),
          TextFieldFormForPassword(),
          const SizedBox(height: 24),
          ElevatedButtonForSignIn(),
        ],
      ),
    );
  }
}
