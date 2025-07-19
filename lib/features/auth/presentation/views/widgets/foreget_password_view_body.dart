import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/widgets/CustomCircleLoading.dart';

import '../../../../../../core/functions/custom_validator.dart';
import '../../../../../../core/widgets/show_err_dialog.dart';
import '../../cubits/forgetpassord/forgetasword_cubit.dart';
import '../resetpassword.dart';

class ForegetPasswordViewBody extends StatefulWidget {
  const ForegetPasswordViewBody({super.key});

  @override
  _ForegetPasswordViewBodyState createState() =>
      _ForegetPasswordViewBodyState();
}

class _ForegetPasswordViewBodyState extends State<ForegetPasswordViewBody> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter your email address below to receive password reset instructions.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: CustomValidator.emailValidator,
              ),
            ),
            const SizedBox(height: 16),
            BlocConsumer<ForgetaswordCubit, ForgetaswordState>(
              listener: (context, state) {
                if (state is ForgetaswordSuccess) {
                  Navigator.pushNamed(context, ResetpasswordView.routeName);
                } else if (state is ForgetaswordError) {
                  showerrorDialog(
                    context: context,
                    title: "!Oops",
                    description: state.message,
                  );
                }
              },
              builder: (context, state) {
                return state is ForgetaswordLoading
                    ? Center(child: CustomCircleLoading())
                    : SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ForgetaswordCubit>().forgetPassword(
                              email: emailController.text,
                            );
                          }
                        },
                        child: const Text("Send"),
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
