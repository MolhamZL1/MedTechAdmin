import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';

class SettingsSideBarItem extends StatelessWidget {
  const SettingsSideBarItem({
    super.key,
    required this.item,
    required this.isSelected,
  });

  final Map item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: SlectedSettingsSideBarITem(item: item),
      secondChild: InslectedSettingsSideBarITem(item: item),
      crossFadeState:
          isSelected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 300),
    );
  }
}

class SlectedSettingsSideBarITem extends StatelessWidget {
  const SlectedSettingsSideBarITem({super.key, required this.item});

  final Map item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary, width: .1),
      ),
      padding: EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            item["title"],
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
        leading: Icon(item["icon"], color: AppColors.primary),
        subtitle: Text(
          item["subtitle"],
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.black87),
        ),
      ),
    );
  }
}

class InslectedSettingsSideBarITem extends StatelessWidget {
  const InslectedSettingsSideBarITem({super.key, required this.item});

  final Map item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            item["title"],
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        leading: Icon(item["icon"]),
        subtitle: Text(
          item["subtitle"],
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.black87),
        ),
      ),
    );
  }
}
