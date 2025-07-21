import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/widgets/CustomCircleLoading.dart';
import 'package:med_tech_admin/core/widgets/showsuccessDialog.dart';
import 'package:med_tech_admin/features/auth/presentation/views/widgets/CustomPasswordTextField.dart';
import 'package:med_tech_admin/features/settings/presentation/cubits/change_password/change_password_cubit.dart';

import '../../../../core/functions/Container_decoration.dart';
import '../../../../core/functions/error_dialog.dart';
import '../../../../core/services/get_it_service.dart';
import '../../../../core/widgets/show_err_dialog.dart';
import '../../domain/rpeos/settings_repo.dart';

class SecuritySettingsViewBody extends StatefulWidget {
  const SecuritySettingsViewBody({super.key});

  @override
  State<SecuritySettingsViewBody> createState() =>
      _SecuritySettingsViewBodyState();
}

class _SecuritySettingsViewBodyState extends State<SecuritySettingsViewBody> {
  String currentPassword = '';
  String newPassword = '';
  String confirmPassword = '';
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(32),
      decoration: containerDecoration(context),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Change Password",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 24),
            Text(
              "Current Password",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 450,
              child: CustomPasswordTextField(
                onSaved: (newValue) {
                  currentPassword = newValue!;
                  setState(() {});
                },
                autovalidateMode: autovalidateMode,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "New Password",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 450,

              child: CustomPasswordTextField(
                onSaved: (newValue) {
                  newPassword = newValue!;
                  setState(() {});
                },
                autovalidateMode: autovalidateMode,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Confirm Password",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 450,

              child: CustomPasswordTextField(
                onSaved: (newValue) {
                  confirmPassword = newValue!;
                  setState(() {});
                },
                autovalidateMode: autovalidateMode,
              ),
            ),
            SizedBox(height: 32),
            BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) {
                if (state is ChangePasswordError) {
                  showerrorDialog(
                    context: context,
                    title: "Error",
                    description: state.message,
                  );
                }
                if (state is ChangePasswordSuccess) {
                  showsuccessDialog(
                    context: context,
                    title: "Congratulations",
                    description: "Password updated successfully",
                  );
                }
              },
              builder: (context, state) {
                if (state is ChangePasswordLoading) {
                  return CustomCircleLoading();
                }
                return ElevatedButton.icon(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (newPassword != confirmPassword) {
                        showWebErrorToast(context, "Passwords do not match");
                        return;
                      } else if (newPassword == currentPassword) {
                        showWebErrorToast(
                          context,
                          "New password cannot be same as current password",
                        );
                        return;
                      } else {
                        context.read<ChangePasswordCubit>().changePassword(
                          currentPassword: currentPassword,
                          newPassword: newPassword,
                        );
                      }
                    } else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  icon: Icon(Icons.lock_outlined),
                  label: Text("Update Password"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Securitysettingsview extends StatelessWidget {
  const Securitysettingsview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(getIt.get<SettingsRepo>()),
      child: const SecuritySettingsViewBody(),
    );
  }
}
