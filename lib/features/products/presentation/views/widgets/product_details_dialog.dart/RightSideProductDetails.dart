import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/widgets/CustomImageNetwork.dart';

import '../../../../domain/entities/product_entity.dart';
import '../product_card/DetailsSectionProductCard.dart';
import '../product_card/ProductDetailsText.dart';
import 'ListTileProductDetails.dart';
import 'VedioItem.dart';

class RightSideProductDetails extends StatelessWidget {
  const RightSideProductDetails({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    log("qrcode");
    log(productEntity.qrCode);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: CustomImageNetwork(imageUrl: productEntity.qrCode),
              ),
              SizedBox(height: 8),
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
          subtitle: productEntity.descriptionEn,
        ),
        // ListTileProductDetails(
        //   title: 'Technical Specifications',
        //   subtitle: "product.description",
        // ),
        // ListTileProductDetails(
        //   title: 'Warranty',
        //   subtitle: "product.description",
        // ),
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
        productEntity.vedios.isEmpty
            ? const Center(
              child: Text("No Vedios", style: TextStyle(color: Colors.black)),
            )
            : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: productEntity.vedios.length,
              itemBuilder:
                  (context, index) =>
                      VedioItem(vedioEntity: productEntity.vedios[index]),
            ),
      ],
    );
  }
}
