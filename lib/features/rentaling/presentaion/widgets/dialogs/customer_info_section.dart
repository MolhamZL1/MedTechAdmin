import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';

import '../../../domain/rental_data.dart';
import '../../../utils/constants.dart';


class CustomerInfoSection extends StatelessWidget {
  final Customer customer;

  const CustomerInfoSection({
    Key? key,
    required this.customer,
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
              customer.name,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              customer.organization,
              style: const TextStyle(
                fontSize: 14.0,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 16.0),
            if (customer.email != null) _buildInfoRow(Icons.email_outlined, customer.email!),
            if (customer.phone != null) _buildInfoRow(Icons.phone_outlined, customer.phone!),
            if (customer.address != null) _buildInfoRow(Icons.location_on_outlined, customer.address!),
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

