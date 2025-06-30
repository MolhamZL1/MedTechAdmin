import 'package:flutter/material.dart';

import '../../../../../../core/functions/infoContainerDcoration.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/CustomImageNetwork.dart';
import '../../../../domain/entities/product_entity.dart';
import '../product_card/FlowedProductsDetails.dart';

class LeftSideProductDetails extends StatelessWidget {
  const LeftSideProductDetails({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: CustomImageNetwork(imageUrl: product.imageUrl),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: FlowedProductsDetails(
                text: product.status,
                color:
                    product.status == "In Stock"
                        ? AppColors.success
                        : product.status == "Low Stock"
                        ? AppColors.warning
                        : AppColors.error,
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: infoContainerDcoration(),
                child: ListTile(
                  title: Text(
                    "Sale Price",
                    style: TextStyle(color: Colors.black54),
                  ),
                  subtitle: Text(
                    r"$" + product.salePrice.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Container(
                decoration: infoContainerDcoration(),
                child: ListTile(
                  title: Text(
                    "Rental/Day",
                    style: TextStyle(color: Colors.black54),
                  ),
                  subtitle: Text(
                    r"$" + product.salePrice.toString(),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
