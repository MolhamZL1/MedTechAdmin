import 'package:flutter/material.dart';

class SideBarLogoSection extends StatelessWidget {
  const SideBarLogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("MediCare", style: Theme.of(context).textTheme.headlineMedium);
  }
}
