import 'package:flutter/material.dart';

class AiMessageBubble extends StatelessWidget {
  const AiMessageBubble({super.key, required this.text, required this.isUser});
  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final userBg = scheme.primary.withOpacity(isDark ? 0.25 : 0.15);
    final aiBg = theme.cardColor.withOpacity(isDark ? 0.35 : 0.9);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 360),
        decoration: BoxDecoration(
          color: isUser ? userBg : aiBg,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isUser ? 12 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 12),
          ),
        ),
        child: Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(height: 1.35),
        ),
      ),
    );
  }
}
