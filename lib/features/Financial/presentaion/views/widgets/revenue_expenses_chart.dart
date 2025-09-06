import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../domain/entity/financial_entity.dart';
import 'buildLegendItem.dart';

class FinancialReportChart extends StatelessWidget {
  final EarningsReportEntity report;

  const FinancialReportChart({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final breakdown = report.revenueBreakdown;
    final summary = report.summary;
    final values = [breakdown.productSales, breakdown.productRentals, breakdown.maintenanceServices, summary.costOfGoodsSold];
    double maxY = 0;
    for (var value in values) {
      if (value > maxY) maxY = value;
    }
    maxY = maxY == 0 ? 100 : maxY * 1.2;

    return Container(
      height: 400,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Financial Summary', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              buildLegendItem('Sales', Colors.blue),
              buildLegendItem('Rentals', Colors.green),
              buildLegendItem('Maintenance', Colors.orange),
              buildLegendItem('Expenses', Colors.red),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BarChart(
              BarChartData(
                maxY: maxY,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '\$${rod.toY.toStringAsFixed(2)}',
                        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        const titles = ['Sales', 'Rentals', 'Maint.', 'Expenses'];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(titles[value.toInt()], style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                barGroups: [
                  _makeGroupData(0, breakdown.productSales, Colors.blue),
                  _makeGroupData(1, breakdown.productRentals, Colors.green),
                  _makeGroupData(2, breakdown.maintenanceServices, Colors.orange),
                  _makeGroupData(3, summary.costOfGoodsSold, Colors.red),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 30,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ],
    );
  }
}
