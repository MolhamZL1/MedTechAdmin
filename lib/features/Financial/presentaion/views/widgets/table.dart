import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import '../../../domain/entity/financial_entity.dart';

class FinancialReportTable extends StatelessWidget {
  final EarningsReportEntity report;

  const FinancialReportTable({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final summary = report.summary;
    final breakdown = report.revenueBreakdown;
    final transactions = report.transactionCounts;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // ✅ 1. بناء قائمة البيانات لتسهيل العرض
    final dataRows = [
      {'label': 'Gross Revenue', 'value': summary.grossRevenue, 'type': 'profit'},
      {'label': '  - Product Sales', 'value': breakdown.productSales, 'type': 'detail'},
      {'label': '  - Product Rentals', 'value': breakdown.productRentals, 'type': 'detail'},
      {'label': '  - Maintenance Services', 'value': breakdown.maintenanceServices, 'type': 'detail'},
      {'label': 'Expenses (COGS)', 'value': summary.costOfGoodsSold, 'type': 'expense'},
      {'label': 'Gross Profit', 'value': summary.grossProfit, 'type': 'profit_bold'},
      {'label': 'Paid Orders', 'value': transactions.paidOrders, 'type': 'count'},
      {'label': 'Completed Maintenance', 'value': transactions.completedMaintenance, 'type': 'count'},
    ];

    // ✅ 2. استخدام Table بدلاً من DataTable للتحكم الكامل في التصميم
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // ✅ 3. إضافة عنوان للجدول
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Financial Report Details',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          // ✅ 4. بناء رأس الجدول (Header)
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey.withOpacity(0.2) : AppColors.primary.withOpacity(0.1),
                  border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3))),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Text(
                      'Metric',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Text(
                      'Value',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // ✅ 5. بناء جسم الجدول (Body)
          Expanded(
            child: ListView.builder(
              itemCount: dataRows.length,
              itemBuilder: (context, index) {
                final row = dataRows[index];
                final isEven = index % 2 == 0;

                // تحديد الألوان والأنماط بناءً على نوع البيانات
                Color rowColor = isEven
                    ? (isDarkMode ? Colors.black.withOpacity(0.2) : Colors.white)
                    : (isDarkMode ? Colors.grey.withOpacity(0.1) : Colors.grey.shade50);

                Color valueColor = Colors.black;
                FontWeight valueWeight = FontWeight.normal;
                String valueString = '';

                if (isDarkMode) {
                  valueColor = Colors.white;
                }

                switch (row['type']) {
                  case 'profit':
                    valueColor = Colors.green.shade400;
                    break;
                  case 'profit_bold':
                    valueColor = Colors.green.shade400;
                    valueWeight = FontWeight.bold;
                    break;
                  case 'expense':
                    valueColor = Colors.red.shade400;
                    valueWeight = FontWeight.bold;
                    break;
                  case 'count':
                    valueString = (row['value'] as int).toString();
                    break;
                  default: // detail
                    valueString = '\$${(row['value'] as double).toStringAsFixed(2)}';
                }

                if (row['type'] != 'count') {
                  valueString = '\$${(row['value'] as double).toStringAsFixed(2)}';
                }

                return Container(
                  color: rowColor,
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(2),
                    },
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                            child: Text(
                              row['label'] as String,
                              style: TextStyle(
                                fontStyle: row['type'] == 'detail' ? FontStyle.italic : FontStyle.normal,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                            child: Text(
                              valueString,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: valueColor,
                                fontWeight: valueWeight,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
