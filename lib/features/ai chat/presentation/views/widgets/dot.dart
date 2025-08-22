import 'package:flutter/material.dart';

class Dot extends StatefulWidget {
  const Dot();
  @override
  State<Dot> createState() => _DotState();
}

class _DotState extends State<Dot> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();
  late final Animation<double> _a = CurvedAnimation(
    parent: _c,
    curve: Curves.easeInOut,
  );

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _a,
      builder: (_, __) {
        final v = 0.4 + (_a.value * 0.6); // 0.4..1.0
        return Opacity(
          opacity: v,
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
