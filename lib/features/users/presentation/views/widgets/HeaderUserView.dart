import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/users/domain/entities/user-entity.dart';
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
            child: Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                SizedBox(height: 5,),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 5,),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 5,),
                TextField(
                  controller: roleController,
                  decoration: InputDecoration(labelText: 'Role'),
                ),
              ],
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
                final cubit = BlocProvider.of<UserCubit>(context);
                final user = UserssEntity(
                  id: '0',
                  username: usernameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  role: roleController.text,

                );

                final message = await cubit.createUser(user);

                if (context.mounted) {
                  Navigator.of(ctx).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message ?? 'An error occurred'),
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.only(top: 40, left: 100, right: 100),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
