import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../domain/entities/product_entity.dart';
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
