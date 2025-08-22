import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import 'package:med_tech_admin/features/Financial/presentaion/views/widgets/revenue_breakdown_chart.dart';
import 'package:med_tech_admin/features/Financial/presentaion/views/widgets/revenue_expenses_chart.dart';
import '../../../../../core/entities/InfoCardEntity.dart';
import '../../../../orders/presentation/views/widgets/InformCardList.dart';
import 'HeraderFinancialView.dart';
class FinancialViewBody extends StatelessWidget {
  const FinancialViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HeaderFinancialView(),
            const SizedBox(height: 24),
            InformCardList(entities: Financiallistinfo),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 400,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.cardColorDark
                          : AppColors.cardColorlight,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const RevenueExpensesChart(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.cardColorDark
                          : AppColors.cardColorlight,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const RevenueBreakdownChart(),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
