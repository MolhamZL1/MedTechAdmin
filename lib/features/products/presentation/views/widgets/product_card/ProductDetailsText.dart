import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/products/domain/entities/product_entity.dart';

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
