import 'package:flutter/material.dart';

import '../../../../domain/entities/product_entity.dart';

class HEaderProductDEtailsDialog extends StatelessWidget {
  const HEaderProductDEtailsDialog({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            product.nameEn,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text('4.8'),
            const SizedBox(width: 4),
            Text('(123 reviews)', style: TextStyle(color: Colors.grey)),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
