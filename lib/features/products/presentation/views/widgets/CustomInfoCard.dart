import 'package:flutter/material.dart';

import '../../../../../core/functions/Container_decoration.dart';

class CustomInfoCard extends StatelessWidget {
  const CustomInfoCard({
    super.key,
    required this.text,
    required this.count,
    required this.icon,
    required this.color,
  });
  final String text;
  final num count;
  final Widget icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: containerDecoration(),
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 8),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(text),
        ),
        subtitle: Text(
          count.toString(),
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(color: color),
        ),
        trailing: icon,
      ),
    );
  }
}
