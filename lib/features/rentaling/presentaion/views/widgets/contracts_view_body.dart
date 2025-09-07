// في ملف: features/contracts/presentation/views/widgets/contracts_view_body.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/entities/InfoCardEntity.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../orders/presentation/views/widgets/InformCardList.dart';
import '../../cubits/contract_cubit.dart';
import '../../cubits/contract_state.dart';
import '../../../../rentaling/presentaion/widgets/dynamic_table.dart';
import '../../widgets/HeaderRentalView.dart';
import 'contract_table_helper.dart';
import '../../../domain/entities/contract-entity.dart';

class ContractsViewBody extends StatelessWidget {
  final int userId;

  const ContractsViewBody({
    super.key,
    required this.userId,
  });

  List<InfoCardEntity> _generateInfoCards(List<ContractEntity> contracts) {
    // ... (الكود هنا لا يتغير)
    final activeCount = contracts.where((c) => c.status.toUpperCase() == 'ACTIVE').length;
    final completedCount = contracts.where((c) => c.status.toUpperCase() == 'COMPLETED').length;
    final pendingCount = contracts.where((c) => c.status.toUpperCase() == 'PENDING').length;
    final totalCount = contracts.length;

    return [
      InfoCardEntity(text: "Total Contracts", count: totalCount.toString(), icon: const Icon(Icons.description, size: 35)),
      InfoCardEntity(color: AppColors.success, text: "Active Contracts", count: activeCount.toString(), icon: Icon(Icons.play_circle_fill, size: 35, color: AppColors.success)),
      InfoCardEntity(color: AppColors.darkGrey, text: "Completed ", count: completedCount.toString(), icon: Icon(Icons.check_circle, size: 35, color: AppColors.darkGrey)),
      InfoCardEntity(color: AppColors.warning, text: "Pending Contracts", count: pendingCount.toString(), icon: Icon(Icons.pending_actions, size: 35, color: AppColors.warning)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractCubit, ContractState>(
      builder: (context, state) {
        if (state is ContractLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading contracts...'),
              ],
            ),
          );
        } else if (state is ContractSuccess) {
          final contracts = state.contracts;
          final tableData = ContractTableHelper.fromContractList(contracts, context);
          final List<InfoCardEntity> rentalsListInfo = _generateInfoCards(contracts);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderRentalsView(), // تأكد من أن هذا الويدجت لا يعتمد على Cubit
                  const SizedBox(height: 24),
                  InformCardList(entities: rentalsListInfo),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.cardColorDark
                          : AppColors.cardColorlight,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 2))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(Icons.table_chart, color: Colors.grey[700]),
                              const SizedBox(width: 8),
                              Text(
                                'Contracts Overview',
                                style:
                                Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold,),
                              ),
                            ],
                          ),
                        ),
                        DynamicTable(tableData: tableData, enableSorting: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is ContractFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text('Error loading contracts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red[700])),
                const SizedBox(height: 8),
                Text(state.errMessage, style: TextStyle(color: Colors.grey[600]), textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<ContractCubit>().fetchContracts(userId: userId);
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        // حالة أولية قبل اختيار أي مستخدم
        return const Center(child: Text('Please select a user to see their contracts.'));
      },
    );
  }
}
