import 'dart:developer';

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
    log("image");
    log(product.imagesUrl[0]);
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: CustomImageNetwork(imageUrl: product.imagesUrl[0]),
            ),
            // Positioned(
            //   top: 10,
            //   right: 10,
            //   child: FlowedProductsDetails(
            //     text: product.status,
            //     color:
            //         product.status == "In Stock"
            //             ? AppColors.success
            //             : product.status == "Low Stock"
            //             ? AppColors.warning
            //             : AppColors.error,
            //   ),
            // ),
          ],
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child:
                  product.availableForSale
                      ? Container(
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
                      )
                      : Container(
                        decoration: infoContainerDcoration(),
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Not for Sale",
                            style: TextStyle(color: AppColors.warning),
                          ),
                        ),
                      ),
            ),
            SizedBox(width: 16),
            Expanded(
              child:
                  product.availableForRent
                      ? Container(
                        decoration: infoContainerDcoration(),
                        child: ListTile(
                          title: Text(
                            "Rental/Day",
                            style: TextStyle(color: Colors.black54),
                          ),
                          subtitle: Text(
                            r"$" + product.salePrice.toString(),
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(color: AppColors.primary),
                          ),
                        ),
                      )
                      : Container(
                        decoration: infoContainerDcoration(),
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Not for Rental",
                            style: TextStyle(color: AppColors.warning),
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
