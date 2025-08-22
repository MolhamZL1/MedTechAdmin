import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../domain/entities/order_entity.dart';


class EquipmentDetailsSection extends StatelessWidget {
  final OrderEntity order;

  const EquipmentDetailsSection({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: 16.0),
        // This section is not present in the image, so it's left empty.
        // If you need to add content here, please provide details.
      ],
    );
  }

}


