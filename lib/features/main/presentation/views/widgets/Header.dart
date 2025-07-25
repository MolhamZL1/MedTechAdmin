import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/functions/get_container_color.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import 'package:med_tech_admin/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/CustomIconButton.dart';

import '../../../../../core/functions/getLocalUser.dart';
import '../../../../auth/domain/entities/user_entity.dart';

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

class UserInfoHeader extends StatefulWidget {
  const UserInfoHeader({super.key});

  @override
  State<UserInfoHeader> createState() => _UserInfoHeaderState();
}

class _UserInfoHeaderState extends State<UserInfoHeader> {
  UserEntity? user;

  @override
  void initState() {
    super.initState();
    getuser();
  }

  getuser() async {
    user = await getLocalUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder:
          (context) => [
            PopupMenuItem(value: 1, child: Text("Settings")),
            PopupMenuItem(value: 2, child: Text("Sign Out")),
          ],
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 150),

        child: ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () {},
          title: Text(
            user?.name ?? "User name",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            "Job Title",
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          trailing: const CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.person_outline, size: 20),
          ),
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
            break;
          case 2:
            context.read<AuthCubit>().signout();
            break;
        }
      },
      itemBuilder:
          (context) => [
            _buildMenuItem(Icons.person_outline, "Profile", 0),
            _buildMenuItem(Icons.help_outline, "Help & Support", 1),
            const PopupMenuDivider(),
            PopupMenuItem<int>(
              value: 2,
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
                "Ahmed Al-Mansouri",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                "Company Manager",
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
