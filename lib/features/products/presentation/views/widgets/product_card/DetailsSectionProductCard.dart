import 'package:flutter/material.dart';

import '../../../../domain/entities/product_entity.dart';
import 'button_card_section.dart';

class DetailsSectionProductCard extends StatelessWidget {
  const DetailsSectionProductCard({
    super.key,
    required this.productEntity,
    required this.lowStock,
  });

  final ProductEntity productEntity;
  final bool lowStock;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productEntity.nameEn,
          style: Theme.of(context).textTheme.headlineMedium,
        ),

        Text(
          productEntity.categoryEn,
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        ProductDetailsText(productEntity: productEntity, lowStock: lowStock),
        const SizedBox(height: 12),
        ButtonsProductCardSection(productEntity: productEntity),
      ],
    );
  }
}

class ProductDetailsText extends StatelessWidget {
  const ProductDetailsText({
    super.key,
    required this.productEntity,
    required this.lowStock,
  });

  final ProductEntity productEntity;
  final bool lowStock;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Sale Price:"),
            Text(
              "\$${productEntity.salePrice.toStringAsFixed(0)}",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Rental/Day:", style: TextStyle(color: Colors.grey[700])),
            Text(
              "\$${productEntity.rentalPrice.toStringAsFixed(0)}",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Stock:", style: TextStyle(color: Colors.grey[700])),
            Text(
              "${productEntity.saleStock} units",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: lowStock ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
