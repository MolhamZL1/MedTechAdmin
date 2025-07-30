import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/users/domain/entities/user-entity.dart';
import '../../../../../core/widgets/show_err_dialog.dart';
import '../../../../../core/widgets/showsuccessDialog.dart';
import '../../../domain/entities/entity.dart';
import '../../cubits/user_cubit.dart';

class HeaderUsersView extends StatelessWidget {
  const HeaderUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          "User Management",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      subtitle: Text(
        "Manage user accounts and permissions",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: ElevatedButton(
        onPressed: () => _showAddUserDialog(context),
        child: Text("Add new user"),
      ),
    );
  }

  void _showAddUserDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final roleController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Add New User"),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: roleController,
                    decoration: InputDecoration(labelText: 'Role'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Role is required';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
            ElevatedButton(
              child: Text("Create"),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final cubit = BlocProvider.of<UserCubit>(context);
                  final user = CreateUserEntity(
                    id: '0',
                    username: usernameController.text.trim(),
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    role: roleController.text.trim(),
                  );

                  final message = await cubit.createUser(user);
                  print('Message from createUser: $message');

                  if (!context.mounted) return;

                  Navigator.of(ctx).pop();

                  Future.microtask(() {
                    if (message == "User created successfully") {
                      showsuccessDialog(
                        context: context,
                        title: "Success",
                        description: message ?? "",
                      );
                    } else {
                      showerrorDialog(
                        context: context,
                        title: "Error",
                        description: message ?? "Failed to create user",
                      );
                    }
                  });
                }
                // إذا ما كان الفورم صحيح، Validator سيعرض الرسائل المناسبة تلقائياً
              },
            ),
          ],
        );
      },
    );
  }
}
