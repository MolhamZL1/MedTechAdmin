import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/widgets/AdaptiveLayout.dart';
import 'package:med_tech_admin/features/products/presentation/views/Desktop_products_View.dart';
import 'package:med_tech_admin/features/products/presentation/views/MobileProductsView.dart';
import 'package:med_tech_admin/features/products/presentation/views/TabletProductsView.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      desktopLayout: (context) => DesktopProductsView(),
      mobileLayout: (context) => MobileProductsView(),
      tabletLayout: (context) => TabletProductsView(),
    );
  }
}
