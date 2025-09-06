import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/entities/InfoCardEntity.dart';
import '../../../../../core/services/api_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/const_variable.dart';
import '../../../../orders/presentation/views/widgets/InformCardList.dart';
import '../../../../rentaling/domain/table_data.dart';
import '../../../../rentaling/presentaion/widgets/dynamic_table.dart';
import '../../../data/repos/maintenance_request_repo_impl.dart';
import '../../../domain/entities/maintenance_request_entity.dart';
import '../../cubits/maintenance_request_cubit.dart';
import '../../cubits/maintenance_request_state.dart';
import 'HeaderMaintenanceView.dart';
import 'maintenance_request_table_helper.dart';

class MaintenanceViewBody extends StatelessWidget {
  const MaintenanceViewBody({super.key});

  List<InfoCardEntity> _generateInfoCards(List<MaintenanceRequestEntity> requests) {
    final pendingCount = requests.where((r) => r.status!.toUpperCase() == 'PENDING').length;
    final inProgressCount = requests.where((r) => r.status!.toUpperCase() == 'IN_PROGRESS').length;
    // totalCount = requests.length;

    final totalCost = requests.fold<double>(0.0, (sum, item) {
      final cost = item.finalCost;
      if (cost is num) {
        return sum + cost!;
      }
      return sum;
    });

    return [
      InfoCardEntity(
        text: "Pending Requests",
        count: pendingCount.toString(),
        icon: Icon(Icons.notifications_active, size: 35),
      ),
      InfoCardEntity(
        color: AppColors.warning,
        text: "In Progress",
        count: inProgressCount.toString(),
        icon: Icon(Icons.timelapse_outlined, size: 35, color: AppColors.warning),
      ),
      InfoCardEntity(
        color: AppColors.success,
        text: "Total Requests",
        count: totalCount.toString(),
        icon: Icon(Icons.list_alt, color: AppColors.success, size: 35), // أيقونة أفضل
      ),
      InfoCardEntity(
        color: AppColors.error,
        text: "Total Cost",
        count: '\$${totalCost.toStringAsFixed(2)}', // تنسيق التكلفة
        icon: Icon(Icons.attach_money_sharp, size: 35, color: AppColors.error),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MaintenanceRequestCubit(
        MaintenanceRequestRepoImpl(databaseService: ApiService()),
      )..fetchMaintenanceRequests(),
      child: BlocBuilder<MaintenanceRequestCubit, MaintenanceRequestState>(
        builder: (context, state) {
          if (state is MaintenanceRequestLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading maintenance requests...'),
                ],
              ),
            );
          } else if (state is MaintenanceRequestSuccess) {
            final List<MaintenanceRequestEntity> requests = state.requests;
            totalCount = requests.length;

            final List<InfoCardEntity> maintenanceListInfo = _generateInfoCards(requests);

            final TableData tableData = MaintenanceRequestTableHelper.fromMaintenanceRequestList(requests, context);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderMaintenanceView(),
                    const SizedBox(height: 24),

                    InformCardList(entities: maintenanceListInfo),

                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.cardColorDark
                            : AppColors.cardColorlight,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Text(
                                  'Requests Overview',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16,),
                          DynamicTable(
                            tableData: tableData,
                            enableSorting: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is MaintenanceRequestFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading maintenance requests',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.red[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.errMessage,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<MaintenanceRequestCubit>().fetchMaintenanceRequests();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('No data yet'));
        },
      ),
    );
  }
}
