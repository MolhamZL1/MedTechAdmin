import 'package:flutter/material.dart';

import '../../../../domain/entities/product_entity.dart';
import 'ProductDetailsText.dart';
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
