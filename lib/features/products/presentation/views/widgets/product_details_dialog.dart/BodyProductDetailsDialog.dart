import 'package:flutter/material.dart';

import '../../../../domain/entities/product_entity.dart';
import 'LeftSideProductDetails.dart';
import 'RightSideProductDetails.dart';

class BodyProductDetailsDialog extends StatelessWidget {
  const BodyProductDetailsDialog({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: LeftSideProductDetails(product: product)),
        SizedBox(width: 24),
        Expanded(child: RightSideProductDetails(productEntity: product)),
      ],
    );
  }
}
