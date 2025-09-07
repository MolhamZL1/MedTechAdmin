import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_tech_admin/core/widgets/show_question_dialog.dart';
// تأكد من استيراد AddMediaCubit
import 'package:med_tech_admin/features/products/presentation/cubits/cubit/add_media_cubit.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/delete%20product/delete_product_cubit.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../domain/entities/product_entity.dart';
import '../add_product_dialog/edit.dart';
import '../product_details_dialog.dart/ProductDetailsDialog.dart';

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
                builder: (context) => ProductDetailsDialog(product: productEntity),
              );
            },
            icon: const Icon(Icons.remove_red_eye_outlined),
            label: const Text("View"),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              // ✨✨ الحل هنا: تغليف الـ Dialog بـ BlocProvider ✨✨
              builder: (_) => BlocProvider(
                create: (context) => AddMediaCubit(), // إنشاء نسخة جديدة من الـ Cubit
                child: ProductEditDialog(product: productEntity),
              ),
            );
          },
          icon: const Icon(
            FontAwesomeIcons.edit,
            size: 15,
            color: AppColors.success,
          ),
        ),
        IconButton(
          onPressed: () {
            showQuestionDialog(
              context: context,
              title: "Delete Product",
              description: "Are you sure you want to delete this product?",
              btnOkOnPress: () {
                context.read<DeleteProductCubit>().deleteProduct(
                  productEntity.id.toString(),
                );
              },
            );
          },
          icon: const Icon(Icons.delete, size: 20, color: AppColors.error),
        ),
      ],
    );
  }
}
