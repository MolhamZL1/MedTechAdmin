import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../domain/rental_data.dart';
import '../../../utils/constants.dart';


class EquipmentDetailsSection extends StatelessWidget {
  final RentalData rental;

  const EquipmentDetailsSection({
    Key? key,
    required this.rental,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.medical_services_outlined,
              size: 20.0,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Equipment Details',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _buildEquipmentInfo(),
      ],
    );
  }

  Widget _buildEquipmentInfo() {
    return Container(
      color: Color.lerp(Color(0xFF6B7280), Colors.white, 0.9),
      width: 400,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rental.equipment,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem('Daily Rate:', rental.formattedDailyRate),
                ),
                Expanded(
                  child: _buildDetailItem('Total Days:', '${rental.period.totalDays}'),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem('Deposit:', rental.formattedDeposit),
                ),
                Expanded(
                  child: _buildDetailItem(
                    'Total Cost:',
                    '\$${rental.total.toStringAsFixed(0).replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},',
                    )}',
                    isHighlighted: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, {bool isHighlighted = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.0,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: isHighlighted ? AppColors.primary : AppColors.textColor,
          ),
        ),
      ],
    );
  }
}

