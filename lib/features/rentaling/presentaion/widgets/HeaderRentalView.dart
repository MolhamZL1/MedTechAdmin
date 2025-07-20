import 'package:flutter/material.dart';

class HeaderRentalsView extends StatelessWidget {
  const HeaderRentalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          "Rental Management",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      subtitle: Text(
        "Track and manage equipment rentals",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add, size: 20),
        label: Text(
          "Add New Rental",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
