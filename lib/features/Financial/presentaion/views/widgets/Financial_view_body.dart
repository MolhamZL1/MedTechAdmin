import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import 'package:med_tech_admin/features/Financial/presentaion/views/widgets/revenue_expenses_chart.dart';
import 'package:med_tech_admin/features/Financial/presentaion/views/widgets/table.dart';
import '../../../../../core/entities/InfoCardEntity.dart';
import '../../../../orders/presentation/views/widgets/InformCardList.dart';
import '../../../domain/entity/financial_entity.dart';
import '../../cubits/cubit.dart';
import '../../cubits/state.dart';
import 'HeraderFinancialView.dart';
import 'revenue_breakdown_chart.dart';

class FinancialViewBody extends StatefulWidget {
  const FinancialViewBody({super.key});

  @override
  State<FinancialViewBody> createState() => _FinancialViewBodyState();
}

class _FinancialViewBodyState extends State<FinancialViewBody> {
  DateTime? _startDate;
  DateTime? _endDate;
  bool _showChart = true; // ✅ 2. إعادة متغير حالة التبديل

  @override
  void initState() {
    super.initState();
    _fetchReport();
  }

  void _fetchReport() {
    context.read<EarningsReportCubit>().fetchEarningsReport(
      startDate: _startDate,
      endDate: _endDate,
    );
  }

  List<InfoCardEntity> _generateInfoCards(EarningsReportEntity report) {
    final summary = report.summary;
    final transactions = report.transactionCounts;
    return [
      InfoCardEntity(
        text: "Gross Revenue",
        count: '\$${summary.grossRevenue.toStringAsFixed(2)}',
        icon: Icon(Icons.trending_up, size: 35, color: AppColors.success),
      ),
      InfoCardEntity(
        color: AppColors.error,
        text: "Expenses (COGS)",
        count: '\$${summary.costOfGoodsSold.toStringAsFixed(2)}',
        icon: Icon(Icons.trending_down, size: 35, color: AppColors.error),
      ),
      InfoCardEntity(
        color: AppColors.primary,
        text: "Gross Profit",
        count: '\$${summary.grossProfit.toStringAsFixed(2)}',
        icon: Icon(Icons.monetization_on, size: 35, color: AppColors.primary),
      ),
      InfoCardEntity(
        color: AppColors.warning,
        text: "Total Transactions",
        count: (transactions.paidOrders + transactions.completedMaintenance).toString(),
        icon: Icon(Icons.receipt_long, size: 35, color: AppColors.warning),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderFinancialView(),
            const SizedBox(height: 24),
            _buildDatePickersAndToggle(), // ✅ 3. إعادة دالة التبديل
            const SizedBox(height: 24),
            BlocBuilder<EarningsReportCubit, EarningsReportState>(
              builder: (context, state) {
                if (state is EarningsReportLoading || state is EarningsReportInitial) {
                  return const SizedBox(height: 400, child: Center(child: CircularProgressIndicator()));
                }
                if (state is EarningsReportFailure) {
                  return SizedBox(height: 400, child: Center(child: Text('Error: ${state.errMessage}')));
                }
                if (state is EarningsReportSuccess) {
                  final report = state.report;
                  final financialListInfo = _generateInfoCards(report);

                  return Column(
                    children: [
                      InformCardList(entities: financialListInfo),
                      const SizedBox(height: 24),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                        child: _showChart
                            ?
                        Row(
                          key: const ValueKey('charts'),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(

                              child: Container(
                                height: 400,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? AppColors.cardColorDark
                                          : Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: FinancialReportChart(report: report),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                height: 400,

                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? AppColors.cardColorDark
                                          : Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: RevenueBreakdownChart(report: report),
                              ),
                            ),
                          ],
                        )
                            :
                        Container(
                          key: const ValueKey('table'),
                          height: 400,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: FinancialReportTable(report: report),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox(height: 400, child: Center(child: Text('No data available.')));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickersAndToggle() {
    final formatter = DateFormat('yyyy-MM-dd');
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            readOnly: true,
            controller: TextEditingController(text: _startDate == null ? '' : formatter.format(_startDate!)),
            decoration: InputDecoration(
              labelText: 'Start Date',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final date = await showDatePicker(context: context, initialDate: _startDate ?? DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2100));
                  if (date != null) setState(() => _startDate = date);
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            readOnly: true,
            controller: TextEditingController(text: _endDate == null ? '' : formatter.format(_endDate!)),
            decoration: InputDecoration(
              labelText: 'End Date',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final date = await showDatePicker(context: context, initialDate: _endDate ?? DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2100));
                  if (date != null) setState(() => _endDate = date);
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: _fetchReport,
          icon: const Icon(Icons.search),
          label: const Text('Filter'),
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
        ),
        const Spacer(),
        ToggleButtons(
          isSelected: [_showChart, !_showChart],
          onPressed: (index) {
            setState(() {
              _showChart = index == 0;
            });
          },
          borderRadius: BorderRadius.circular(8),
          children: const [
            Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Icon(Icons.bar_chart)),
            Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Icon(Icons.table_chart)),
          ],
        ),
      ],
    );
  }
}
