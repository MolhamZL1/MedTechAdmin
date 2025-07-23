import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/functions/Container_decoration.dart';
import 'package:med_tech_admin/core/widgets/CategoryDropdown.dart';
import 'package:med_tech_admin/core/widgets/CustomCircleLoading.dart';
import 'package:med_tech_admin/core/widgets/responsive.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/get%20products/get_products_cubit.dart';

import '../../../../core/entities/InfoCardEntity.dart';
import 'widgets/HeaderProductsView.dart';
import 'widgets/InfoCardList.dart';
import 'widgets/ProductsGridView.dart';

class ProductsViewBody extends StatelessWidget {
  const ProductsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    const categories = [
      "All Categories",
      "Diagnostic",
      "Life Support",
      "Emergency",
      "Monitoring",
    ];

    return Column(
      children: [
        HeaderProductsView(),
        SizedBox(height: 24),
        InfoCardList(entities: productinfolist),
        SizedBox(height: 24),
        Container(
          decoration: containerDecoration(context),
          padding: EdgeInsets.all(24),
          child: SearchSectionProductView(categories: categories),
        ),
        SizedBox(height: 24),
        BlocBuilder<GetProductsCubit, GetProductsState>(
          builder: (context, state) {
            if (state is GetProductsSuccess) {
              return ProductsGridView(products: state.products);
            } else if (state is GetProductsError) {
              return Center(child: Text(state.message));
            } else {
              return CustomCircleLoading();
            }
          },
        ),
      ],
    );
  }
}

class SearchSectionProductView extends StatelessWidget {
  const SearchSectionProductView({super.key, required this.categories});

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search_outlined),
                hintText: "Search Products...",
              ),
            ),
            SizedBox(height: 16), // مسافة بسيطة بين الحقل والقائمة
            CategoryDropdown(
              categories: categories,
              selected: categories[0],
              onChanged: (value) {},
            ),
          ],
        )
        : Row(
          children: [
            Flexible(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_outlined),
                  hintText: "Search Products...",
                ),
              ),
            ),
            Spacer(),
            CategoryDropdown(
              categories: categories,
              selected: categories[0],
              onChanged: (value) {},
            ),
          ],
        );
  }
}
