import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_tech_admin/core/widgets/CustomImageNetwork.dart';
import 'package:med_tech_admin/features/products/domain/entities/vedio_entity.dart';

import '../../../../../../core/functions/infoContainerDcoration.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../domain/entities/product_entity.dart';
import '../product_card/DetailsSectionProductCard.dart';
import '../product_card/FlowedProductsDetails.dart';

class ProductDetailsDialog extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsDialog({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
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
      ],
    );
  }
}

class VedioItem extends StatelessWidget {
  const VedioItem({super.key, required this.vedioEntity});
  final VedioEntity vedioEntity;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.abc_outlined),
      title: Text(vedioEntity.title),
      subtitle: Text(vedioEntity.descrption),
    );
  }
}

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

class ListTileProductDetails extends StatelessWidget {
  const ListTileProductDetails({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
      ),
    );
  }
}

class HEaderProductDEtailsDialog extends StatelessWidget {
  const HEaderProductDEtailsDialog({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            product.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text('4.8'),
            const SizedBox(width: 4),
            Text('(123 reviews)', style: TextStyle(color: Colors.grey)),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

class FooterProductDetails extends StatelessWidget {
  const FooterProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton.icon(
            icon: Icon(FontAwesomeIcons.edit, size: 14),
            onPressed: () {},
            label: Text("Edit Product"),
          ),
        ],
      ),
    );
  }
}
