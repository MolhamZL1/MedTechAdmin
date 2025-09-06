import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../domain/entities/order_entity.dart';


class RentalTimelineSection extends StatelessWidget {
  final OrderEntity order;

  const RentalTimelineSection({
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
              Icons.calendar_today_outlined,
              size: 20.0,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Delivery Information',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _buildDeliveryDetails(),
      ],
    );
  }

  Widget _buildDeliveryDetails() {
    return Container(
      width: 400,
      height: 100, // Adjusted height
      color: Color.lerp(Color(0xFF6B7280), Colors.white, 0.9),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _buildDateRow('Estimated Delivery:', _formatDate(order.createdAt.add(Duration(days: 7)))), // Assuming 7 days for estimated delivery
            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRow(String label, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14.0,
            color: AppColors.textColor,
          ),
        ),
        Text(
          date,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}


