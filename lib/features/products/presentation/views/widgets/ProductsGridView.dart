import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/widgets/responsive.dart';

import '../../../domain/entities/product_entity.dart';
import 'ProductCard.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key, required this.products});
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            Responsive.isDesktop(context)
                ? 3
                : Responsive.isTablet(context)
                ? 2
                : 1,
        mainAxisExtent: 430,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          productEntity: ProductEntity(
            id: products[index].id.toString(),
            imageUrl: products[index].imageUrl,
            name: products[index].name,
            category: products[index].category,
            salePrice: products[index].salePrice,
            rentalPrice: products[index].rentalPrice,
            stock: products[index].stock,
            status: products[index].status,
          ),
        );
      },
    );
  }
}
