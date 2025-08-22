import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../data/sample_data.dart';
class RevenueBreakdownChart extends StatefulWidget {
  const RevenueBreakdownChart({super.key});
  @override
  State<RevenueBreakdownChart> createState() => _RevenueBreakdownChartState();
}
class _RevenueBreakdownChartState extends State<RevenueBreakdownChart> {
  String? hoveredItem;
  @override
  Widget build(BuildContext context) {
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
              children: sampleData.revenueBreakdown.entries.map((entry) {
                final data = entry.value;
                final isHovered = hoveredItem == entry.key;
                final baseColor = Color(data['color']);
                final displayColor = isHovered
                    ? Color.fromRGBO(
                  (baseColor.red * 0.8).round(),
                  (baseColor.green * 0.8).round(),
                  (baseColor.blue * 0.8).round(),
                  1.0,
                )
                    : baseColor;
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
                                '${data['percentage']}%',
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
                                :Color(0xFF1A202C)
                                : Theme.of(context).brightness == Brightness.dark
                                ? AppColors.cardColorlight
                                : Color(0xFF2D3748),
                          ),
                          child: Text(
                            '\$${_formatNumber(data['amount'])}',
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
  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(0)},${(number % 1000).toString().padLeft(3, '0')}';
    }
    return number.toString();
  }
}

