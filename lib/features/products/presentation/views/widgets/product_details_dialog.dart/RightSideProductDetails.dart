import 'package:flutter/material.dart';

import '../../../../domain/entities/product_entity.dart';
import '../product_card/DetailsSectionProductCard.dart';
import 'ListTileProductDetails.dart';
import 'VedioItem.dart';

class RightSideProductDetails extends StatelessWidget {
  const RightSideProductDetails({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Product Details",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              SizedBox(height: 8),
              ProductDetailsText(productEntity: productEntity, lowStock: false),
            ],
          ),
        ),
        ListTileProductDetails(
          title: 'Description',
          subtitle: "product.description",
        ),
        ListTileProductDetails(
          title: 'Technical Specifications',
          subtitle: "product.description",
        ),
        ListTileProductDetails(
          title: 'Warranty',
          subtitle: "product.description",
        ),
        ListTile(
          leading: Icon(Icons.video_collection_outlined),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Training Videos",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: productEntity.vedioEntities.length,
          itemBuilder:
              (context, index) =>
                  VedioItem(vedioEntity: productEntity.vedioEntities[index]),
        ),
      ],
    );
  }
}
