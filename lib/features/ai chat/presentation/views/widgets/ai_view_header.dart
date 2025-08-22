import 'package:flutter/material.dart';

class AiHeader extends StatelessWidget {
  const AiHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBack,
    this.heroTag,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onBack;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final avatar = CircleAvatar(
      radius: 21,
      backgroundColor: theme.colorScheme.primary,
      child: Icon(Icons.smart_toy_outlined, color: theme.colorScheme.onPrimary),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 4),
          // لو heroTag موجود، لفّ الـ avatar بـ Hero بنفس التاغ
          heroTag != null ? Hero(tag: heroTag!, child: avatar) : avatar,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
