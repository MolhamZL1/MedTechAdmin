import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/widgets/CustomCircleLoading.dart';

import '../../../../../../core/functions/custom_validator.dart';
import '../../../../../../core/widgets/show_err_dialog.dart';
import '../../cubits/resetpassword/resetpassword_cubit.dart';
import '../sign_in_view.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final GlobalKey<FormState> reskey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newpassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: reskey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please enter your registered email address, the reset code you received, and your new password.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: CustomValidator.emailValidator,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: 'Reset Code',
                  prefixIcon: Icon(Icons.code),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the reset code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: newpassController,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter your new password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: CustomValidator.passwordValidator,
              ),
              const SizedBox(height: 30),
              BlocConsumer<ResetpasswordCubit, ResetpasswordState>(
                listener: (context, state) {
                  if (state is ResetPasswordSuccess) {
                    Navigator.pushReplacementNamed(
                      context,
                      SignInView.routeName,
                    );
                  } else if (state is ResetPasswordError) {
                    showerrorDialog(
                      context: context,
                      title: "!Oops",
                      description: state.message,
                    );
                  }
                },
                builder: (context, state) {
                  return state is ResetPasswordLoading
                      ? Center(child: CustomCircleLoading())
                      : SizedBox(
                        width: double.infinity,

                        child: ElevatedButton(
                          onPressed: () {
                            if (reskey.currentState!.validate()) {
                              context.read<ResetpasswordCubit>().resetpassword(
                                email: emailController.text,
                                code: codeController.text,
                                newpassword: newpassController.text,
                              );
                            }
                          },
                          child: const Text("Submit"),
                        ),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
