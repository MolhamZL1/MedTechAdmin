import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import 'package:intl/intl.dart';

import '../../../domain/entity/financial_entity.dart';

class RevenueBreakdownChart extends StatefulWidget {
  final EarningsReportEntity report;

  const RevenueBreakdownChart({
    super.key,
    required this.report,
  });

  @override
  State<RevenueBreakdownChart> createState() => _RevenueBreakdownChartState();
}

class _RevenueBreakdownChartState extends State<RevenueBreakdownChart> {
  String? hoveredItem;

  @override
  Widget build(BuildContext context) {
    final breakdown = widget.report.revenueBreakdown;
    final totalRevenue = widget.report.summary.grossRevenue;
    final safeTotalRevenue = totalRevenue == 0 ? 1 : totalRevenue;

    final breakdownData = {
      'Product Sales': {
        'amount': breakdown.productSales,
        'percentage': (breakdown.productSales / safeTotalRevenue) * 100,
        'color': 0xFF2196F3,
      },
      'Product Rentals': {
        'amount': breakdown.productRentals,
        'percentage': (breakdown.productRentals / safeTotalRevenue) * 100,
        'color': 0xFF4CAF50,
      },
      'Maintenance Services': {
        'amount': breakdown.maintenanceServices,
        'percentage': (breakdown.maintenanceServices / safeTotalRevenue) * 100,
        'color': 0xFFFF9800,
      },
    };

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Revenue Breakdown',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Column(
              children: breakdownData.entries.map((entry) {
                final data = entry.value;
                final isHovered = hoveredItem == entry.key;
                final baseColor = Color(data['color'] as int);
                final displayColor = isHovered
                    ? Color.fromRGBO(
                  (baseColor.red * 0.8).round(),
                  (baseColor.green * 0.8).round(),
                  (baseColor.blue * 0.8).round(),
                  1.0,
                )
                    : baseColor;

                // ✅✅✅ تم حذف الشرط من هنا ✅✅✅
                // if (data['amount'] == 0.0) {
                //   return const SizedBox.shrink();
                // }

                return MouseRegion(
                  onEnter: (_) => setState(() => hoveredItem = entry.key),
                  onExit: (_) => setState(() => hoveredItem = null),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: displayColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: isHovered
                          ? Border.all(color: displayColor.withOpacity(0.7), width: 2)
                          : null,
                    ),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: displayColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.key,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                '${(data['percentage'] as double).toStringAsFixed(1)}%',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF718096),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            fontSize: isHovered ? 17 : 16,
                            fontWeight: FontWeight.w600,
                            color: isHovered
                                ? Theme.of(context).brightness == Brightness.dark
                                ? AppColors.cardColorlight
                                : const Color(0xFF1A202C)
                                : Theme.of(context).brightness == Brightness.dark
                                ? AppColors.cardColorlight
                                : const Color(0xFF2D3748),
                          ),
                          child: Text(
                            _formatCurrency(data['amount'] as double),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double number) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2).format(number);
  }
}
