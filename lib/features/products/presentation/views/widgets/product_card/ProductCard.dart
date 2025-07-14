import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/functions/Container_decoration.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/CustomImageNetwork.dart';
import '../../../../domain/entities/product_entity.dart';
import 'DetailsSectionProductCard.dart';
import 'FlowedProductsDetails.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductCard({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    final bool lowStock = productEntity.stock <= 1;

    return Container(
      decoration: containerDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: SizedBox(
                  height: 200,
                  child: CustomImageNetwork(imageUrl: productEntity.imageUrl),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: FlowedProductsDetails(
                  text: productEntity.status,
                  color:
                      productEntity.status == "In Stock"
                          ? AppColors.success
                          : productEntity.status == "Low Stock"
                          ? AppColors.warning
                          : AppColors.error,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: DetailsSectionProductCard(
              productEntity: productEntity,
              lowStock: lowStock,
            ),
          ),
        ],
      ),
    );
  }
}
