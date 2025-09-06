import 'package:flutter/material.dart';

import 'dot.dart';

class TypingBubble extends StatelessWidget {
  const TypingBubble();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = theme.cardColor.withOpacity(
      theme.brightness == Brightness.dark ? 0.35 : 0.9,
    );

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 200),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
            bottomLeft: Radius.circular(4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Dot(),
            SizedBox(width: 4),
            Dot(),
            SizedBox(width: 4),
            Dot(),
          ],
        ),
      ),
    );
  }
}
