import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';

class SideBarItem extends StatelessWidget {
  const SideBarItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.widthAnimation,
  });
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Animation<double> widthAnimation;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: _SideBarItem(
        title: widthAnimation.value > 100 ? title : null,
        icon: icon,
        onTap: onTap,
      ),
      secondChild: _SideBarItemSelected(
        title: widthAnimation.value > 100 ? title : null,
        icon: icon,
        onTap: onTap,
      ),
      crossFadeState:
          isSelected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
}

class _SideBarItem extends StatelessWidget {
  const _SideBarItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String? title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title:
          title == null
              ? null
              : Text(title!, style: Theme.of(context).textTheme.bodyLarge),
      onTap: onTap,
    );
  }
}

class _SideBarItemSelected extends StatelessWidget {
  const _SideBarItemSelected({
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String? title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primary.withOpacity(.1),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                leading: Icon(icon, color: AppColors.primary),
                title:
                    title == null
                        ? null
                        : Text(
                          title!,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColors.primary),
                        ),
                onTap: onTap,
              ),
            ),
            Container(width: 3, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
