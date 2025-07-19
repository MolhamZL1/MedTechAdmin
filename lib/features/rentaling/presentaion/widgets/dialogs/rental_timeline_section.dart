import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../domain/rental_data.dart';
import '../../../utils/constants.dart';


class RentalTimelineSection extends StatelessWidget {
  final RentalPeriod period;

  const RentalTimelineSection({
    Key? key,
    required this.period,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.schedule_outlined,
              size: 20.0,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Rental Timeline',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _buildTimelineDetails(),
      ],
    );
  }

  Widget _buildTimelineDetails() {
    return Container(
      width: 400,
      height: 200,

      color: Color.lerp(Color(0xFF6B7280), Colors.white, 0.9),

      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _buildDateRow('Start Date:', _formatDate(period.startDate)),
            const SizedBox(height: 12.0),
            _buildDateRow('End Date:', _formatDate(period.endDate)),
            const SizedBox(height: 16.0),
            _buildProgressSection(),
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

  Widget _buildProgressSection() {
    final progressPercentage = (period.progress * 100).round();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Progress',
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.textColor,
              ),
            ),
            Text(
              '$progressPercentage%',
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        LinearProgressIndicator(
          value: period.progress,
          backgroundColor: AppConstants.borderColor,
          valueColor: AlwaysStoppedAnimation<Color>(
            period.isOverdue 
                ? AppColors.primary
                : period.expiresSoon 
                    ? AppConstants.expiresSoonColor
                    : AppConstants.accentText,
          ),
          minHeight: 6.0,
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

