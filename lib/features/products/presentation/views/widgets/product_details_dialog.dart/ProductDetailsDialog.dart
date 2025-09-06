import 'package:flutter/material.dart';

import '../../../../domain/entities/product_entity.dart';
import 'BodyProductDetailsDialog.dart';
import 'FooterProductDetails.dart';
import 'HEaderProductDEtailsDialog.dart';

class ProductDetailsDialog extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsDialog({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(16),right:Radius.circular(16) ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .8,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HEaderProductDEtailsDialog(product: product),
              Divider(color: Colors.grey, thickness: .4, height: 0),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: BodyProductDetailsDialog(product: product),
              ),
              Divider(color: Colors.grey, thickness: .4, height: 0),
              FooterProductDetails(),
            ],
          ),
        ),
      ),
    );
  }
}
