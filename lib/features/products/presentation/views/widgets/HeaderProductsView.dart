import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/cubit/add_media_cubit.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/get%20products/get_products_cubit.dart';

import '../../../../../core/services/get_it_service.dart';
import '../../../domain/repos/products_repo.dart';
import '../../cubits/add product/add_product_cubit.dart';
import 'add_product_dialog/add_product_dialog.dart';

class HeaderProductsView extends StatelessWidget {
  const HeaderProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          "Products",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      subtitle: Text(
        "Manage your medical equipment inventory",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          REfreshButton(
            onTap: () {
              context.read<GetProductsCubit>().getProducts();
            },
          ),
          SizedBox(width: 20),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create:
                              (context) =>
                                  AddProductCubit(getIt.get<ProductsRepo>()),
                        ),
                        BlocProvider(create: (context) => AddMediaCubit()),
                      ],
                      child: const ProductAddDialog(),
                    ),
              );
            },
            icon: const Icon(Icons.add, size: 20),
            label: Text(
              "Add Product",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class REfreshButton extends StatelessWidget {
  const REfreshButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary),
        ),
        padding: EdgeInsets.all(8),
        child: Icon(Icons.refresh, color: AppColors.primary),
      ),
    );
  }
}
