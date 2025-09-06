import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/functions/get_container_color.dart';
import 'package:med_tech_admin/core/utils/const_variable.dart';
import 'package:med_tech_admin/core/widgets/show_question_dialog.dart';
import 'package:med_tech_admin/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:med_tech_admin/features/auth/presentation/views/sign_in_view.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/CustomIconButton.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,

      child: Container(
        height: 66,
        padding: EdgeInsets.symmetric(horizontal: 24),
        color: getContainerColor(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomIconButton(icon: Icons.notifications_outlined, onTap: () {}),
            SizedBox(width: 10),
            ProfileMenu(),
          ],
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      offset: const Offset(0, 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) {
        switch (value) {
          case 0:
            break;

          case 1:
            final navigator = Navigator.of(context);
            showQuestionDialog(
              context: context,
              title: "Sign Out",
              description: "Are you sure you want to sign out",
              btnOkOnPress: () async {
                showDialog(
                  context: context,
                  builder:
                      (context) =>
                          const Center(child: CircularProgressIndicator()),
                );

                await context.read<AuthCubit>().signout();
                if (navigator.mounted) {
                  navigator.pushReplacementNamed(SignInView.routeName);
                }
              },
            );
            break;
        }
      },
      itemBuilder:
          (context) => [
            _buildMenuItem(Icons.help_outline, "Help & Support", 0),
            const PopupMenuDivider(),
            PopupMenuItem<int>(
              value: 1,
              child: Row(
                children: const [
                  Icon(Icons.logout_outlined, color: Colors.red),
                  SizedBox(width: 10),
                  Text("Sign Out", style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                myName,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                myRlole,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          const CircleAvatar(
            radius: 18,
            child: Icon(Icons.person_outline, color: Colors.white),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<int> _buildMenuItem(IconData icon, String text, int value) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}
