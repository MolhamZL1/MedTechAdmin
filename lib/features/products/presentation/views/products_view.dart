import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/services/get_it_service.dart';
import 'package:med_tech_admin/core/widgets/show_err_dialog.dart';
import 'package:med_tech_admin/core/widgets/showsuccessDialog.dart';
import 'package:med_tech_admin/features/products/domain/repos/products_repo.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/delete%20product/delete_product_cubit.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/get%20products/get_products_cubit.dart';
import 'package:med_tech_admin/features/products/presentation/views/products_view_body.dart';

import '../cubits/add product/add_product_cubit.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProductsCubit(getIt.get<ProductsRepo>()),
        ),
        BlocProvider(
          create: (context) => DeleteProductCubit(getIt.get<ProductsRepo>()),
        ),
      ],
      child: BlocListener<DeleteProductCubit, DeleteProductState>(
        listener: (context, state) {
          if (state is DeleteProductSuccess) {
            Navigator.of(context, rootNavigator: true).pop(); // Dismiss loading
            showsuccessDialog(
              context: context,
              title: "Success",
              description: "Product Deleted Successfully",
            );
            context.read<GetProductsCubit>().getProducts();
          } else if (state is DeleteProductError) {
            Navigator.of(context, rootNavigator: true).pop(); // Dismiss loading
            showerrorDialog(
              context: context,
              title: "Error",
              description: state.errMessage,
            );
          } else if (state is DeleteProductLoading) {
            showDialog(
              context: context,
              builder:
                  (context) => const Center(child: CircularProgressIndicator()),
            );
          }
        },
        child: ProductsViewBody(),
      ),
    );
  }
}
