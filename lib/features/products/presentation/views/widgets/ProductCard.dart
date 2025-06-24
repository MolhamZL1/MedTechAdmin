import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_tech_admin/core/functions/Container_decoration.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/CustomImageNetwork.dart';
import '../../../domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductCard({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    final bool lowStock = productEntity.stock <= 1;

    return Container(
      //  height: 500,
      decoration: containerDecoration(),
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
          productEntity.name,
          style: Theme.of(context).textTheme.headlineMedium,
        ),

        Text(productEntity.category, style: TextStyle(color: Colors.grey[600])),
        const SizedBox(height: 12),
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
              "${productEntity.stock} units",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: lowStock ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ButtonsProductCardSection(productEntity: productEntity),
      ],
    );
  }
}

class FlowedProductsDetails extends StatelessWidget {
  const FlowedProductsDetails({
    super.key,
    required this.text,
    required this.color,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
      ),
    );
  }
}

class ButtonsProductCardSection extends StatelessWidget {
  const ButtonsProductCardSection({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => ProductDetailsDialog(product: productEntity),
              );
            },
            icon: const Icon(Icons.remove_red_eye_outlined),
            label: const Text("View"),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            FontAwesomeIcons.edit,
            size: 15,
            color: AppColors.success,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete, size: 20, color: AppColors.error),
        ),
      ],
    );
  }
}

class ProductDetailsDialog extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsDialog({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 900,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Body Content
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Left - Image & Price
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            product.imageUrl,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _PriceTile(
                              title: "Sale Price",
                              value: "\$${product.salePrice}",
                            ),
                            const SizedBox(width: 12),
                            _PriceTile(
                              title: "Rental/Day",
                              value: "\$${product.rentalPrice}",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 24),

                  /// Right - Details
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _detail("Category", product.category),
                        // _detail("Brand", product.brand),
                        // _detail("Model", product.model),
                        _detail(
                          "Stock",
                          "${product.stock} units",
                          color: Colors.green,
                        ),
                        _detail(
                          "Status",
                          product.stock > 2 ? "Available" : "Low Stock",
                          badge:
                              product.stock > 2
                                  ? Colors.green[100]
                                  : Colors.orange[100],
                        ),
                        const SizedBox(height: 16),
                        // _sectionTitle("Description"),
                        // Text(product.description),
                        const SizedBox(height: 12),
                        // _sectionTitle("Technical Specifications"),
                        // Text(product.specs),
                        // const SizedBox(height: 12),
                        // _sectionTitle("Warranty"),
                        // Text(product.warranty),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _detail(String label, String value, {Color? color, Color? badge}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text("$label:")),
          badge != null
              ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badge,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(value, style: TextStyle(color: Colors.black87)),
              )
              : Text(value, style: TextStyle(color: color ?? Colors.black)),
        ],
      ),
    );
  }
}

class _PriceTile extends StatelessWidget {
  final String title;
  final String value;
  const _PriceTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
