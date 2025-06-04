import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildShadowText(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(
          blurRadius: 10,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          offset: const Offset(2, 2),
        ),
      ],
    ),
  );
}