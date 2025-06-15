import 'package:flutter/material.dart';
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
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomIconButton(icon: Icons.notifications_outlined, onTap: () {}),
            SizedBox(width: 10),
            CustomIconButton(icon: Icons.logout_outlined, onTap: () {}),
          ],
        ),
      ),
    );
  }
}
