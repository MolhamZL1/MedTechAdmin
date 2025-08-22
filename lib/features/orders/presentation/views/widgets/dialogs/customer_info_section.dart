import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';

import '../../../../domain/entities/order_entity.dart';



class CustomerInfoSection extends StatelessWidget {
  final OrderEntity order;

  const CustomerInfoSection({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.person_outline,
              size: 20.0,


              color: AppColors.primary,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Customer Information',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _buildCustomerDetails(),
      ],
    );
  }

  Widget _buildCustomerDetails() {
    return Container(
      color: Color.lerp(Color(0xFF6B7280), Colors.white, 0.9),
      width: 400,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.user.username,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 4.0),

            const SizedBox(height: 16.0),
            if (order.user.email != null) _buildInfoRow(Icons.email_outlined, order.user.email!),
            _buildInfoRow(Icons.location_on_outlined, order.shippingAddress),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16.0,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14.0,
                color: AppColors.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

