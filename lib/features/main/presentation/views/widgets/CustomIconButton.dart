import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.icon, required this.onTap});
  final IconData icon;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        onTap: onTap,
        child: Padding(padding: const EdgeInsets.all(7.0), child: Icon(icon)),
      ),
    );
  }
}
