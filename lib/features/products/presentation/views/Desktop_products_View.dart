import 'package:flutter/material.dart';

class DesktopProductsView extends StatelessWidget {
  const DesktopProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderProductsView(),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(children: [Expanded(child: TextField())]),
        ),
      ],
    );
  }
}

class HeaderProductsView extends StatelessWidget {
  const HeaderProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text("Products", style: Theme.of(context).textTheme.headlineLarge),
      subtitle: Text(
        "Manage your medical equipment inventory",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add, size: 20),
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Text(
            "Add Product",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
