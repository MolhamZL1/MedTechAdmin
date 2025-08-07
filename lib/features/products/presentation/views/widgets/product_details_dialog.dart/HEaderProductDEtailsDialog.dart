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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.categoryEn,
              style: const TextStyle(color: Colors.grey),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(product.rate.toString()),
                const SizedBox(width: 4),
                Text('(0 reviews)', style: TextStyle(color: Colors.grey)),
              ],
            ),
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
