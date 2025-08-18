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
      trailing: ElevatedButton.icon(
        onPressed: () => _showAddUserDialog(context),
        icon: const Icon(Icons.add, size: 20),
        label: Text(
          "Add User",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  void _showAddUserDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    String? selectedRole; // بدل TextEditingController

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
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
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

                  /// 🔽 Dropdown للـ Role
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    decoration: InputDecoration(labelText: 'Role'),
                    items: const [
                      DropdownMenuItem(
                        value: "USER",
                        child: Row(
                          children: [
                            Icon(Icons.person, color: Colors.blue),
                            SizedBox(width: 8),
                            Text("User"),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "ACCOUNTANT",
                        child: Row(
                          children: [
                            Icon(Icons.account_balance_wallet, color: Colors.green),
                            SizedBox(width: 8),
                            Text("Accountant"),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "MAINTENANCE",
                        child: Row(
                          children: [
                            Icon(Icons.build, color: Colors.orange),
                            SizedBox(width: 8),
                            Text("Maintenance"),
                          ],
                        ),
                      ),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Role is required";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      selectedRole = value;
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
                    role: selectedRole ?? "",
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
              },
            ),
          ],
        );
      },
    );
  }
}
