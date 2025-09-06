import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/users/domain/entities/user-entity.dart';
import 'package:med_tech_admin/features/users/presentation/views/widgets/HeaderUserView.dart';

import '../../../../../core/entities/InfoCardEntity.dart';
import '../../../../../core/services/get_it_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../auth/domain/entities/user_entity.dart';
import '../../../../orders/presentation/views/widgets/InformCardList.dart';
import '../../../../rentaling/presentaion/widgets/dynamic_table.dart';
import '../../../Data/models/user_model.dart';
import '../../../domain/repos/user_repo.dart';
import 'user table helper.dart';
import '../../cubits/user_cubit.dart';

class UserViewBody extends StatelessWidget {
  const UserViewBody({super.key});

  List<InfoCardEntity> _generateInfoCards(List<GetUserEntity> users) {
    final regularUsersCount = users.where((user) => user.role.toUpperCase() == 'USER').length;

    final employeesCount = users.where((user) =>
        ['ACCOUNTANT', 'MAINTENANCE', 'ADMIN'].contains(user.role.toUpperCase())).length;

    final totalUsersCount = users.length;

    return [
      InfoCardEntity(
        text: "Total Users",
        count: totalUsersCount.toString(),
        icon: Icon(Icons.groups, size: 35),
      ),
      InfoCardEntity(
        color: AppColors.warning,
        text: "Regular Users",
        count: regularUsersCount.toString(),
        icon: Icon(Icons.person, size: 35, color: AppColors.warning),
      ),
      InfoCardEntity(
        color: AppColors.success,
        text: "Employees",
        count: employeesCount.toString(),
        icon: Icon(Icons.business_center, color: AppColors.success, size: 35),
      ),
      InfoCardEntity(
        color: AppColors.statusDefault, // لون جديد مناسب
        text: "Active Users", // مثال على إحصائية إضافية
        count: "N/A", // يمكنك حسابها إذا كان لديك حقل `isActive`
        icon: Icon(Icons.check_circle, size: 35, color: AppColors.statusDefault),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(getIt.get<UserRepo>())..fetchUsers(),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading users...'),
                ],
              ),
            );
          } else if (state is UserSuccess) {
            final cubit = BlocProvider.of<UserCubit>(context);

            final regularUsers = state.usersEntity.where((user) =>
            user.role.toUpperCase() == 'USER').toList();

            final employees = state.usersEntity.where((user) =>
                ['ACCOUNTANT', 'MAINTENANCE', 'ADMIN'].contains(user.role.toUpperCase())).toList();

            final regularUsersTableData = UserTableHelper.fromUserList(regularUsers, cubit, context);
            final employeesTableData = UserTableHelper.fromUserList(employees, cubit, context);

            final List<InfoCardEntity> usersListInfo = _generateInfoCards(state.usersEntity);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    HeaderUsersView(),
                    const SizedBox(height: 24),

                    InformCardList(entities: usersListInfo),

                    const SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.business_center, color: Colors.green, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                'Company Employees',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Accountants, Maintenance Technicians, and Managers',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 16),
                          DynamicTable(
                            tableData: employeesTableData,
                            enableSorting: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // قسم المستخدمين العاديين
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.people, color: Colors.blue, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                'Regular Users ',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          DynamicTable(
                            tableData: regularUsersTableData,
                            enableSorting: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is UserFailure) {
            return Center(child: Text('Error: ${state.errMessage}'));
          }
          return const Center(child: Text('No data yet'));
        },
      ),
    );
  }
}
