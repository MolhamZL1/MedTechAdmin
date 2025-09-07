// في ملف: features/contracts/presentation/views/contracts_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:med_tech_admin/core/services/api_service.dart';
import 'package:med_tech_admin/features/users/domain/entities/user-entity.dart';
import '../../../../core/services/get_it_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../users/Data/repos/user_repo_imp.dart';
import '../../../users/domain/repos/user_repo.dart';
import '../../../users/presentation/cubits/user_cubit.dart';
import '../../data/repos/contract_repo_impl.dart';
import '../cubits/contract_cubit.dart';
import 'widgets/contracts_view_body.dart';

class ContractsView extends StatelessWidget {
  const ContractsView({super.key});

  @override
  Widget build(BuildContext context) {
    // توفير الـ Cubits اللازمة للشاشة بأكملها
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(getIt.get<UserRepo>())..fetchUsers(),
        ),
        BlocProvider(
          create: (context) => ContractCubit(ContractRepoImpl(databaseService: ApiService())),
        ),
      ],
      child: const ContractsViewLayout(),
    );
  }
}

class ContractsViewLayout extends StatefulWidget {
  const ContractsViewLayout({super.key});

  @override
  State<ContractsViewLayout> createState() => _ContractsViewLayoutState();
}

class _ContractsViewLayoutState extends State<ContractsViewLayout> {
  int? _selectedUserId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          // عند تحميل المستخدمين بنجاح لأول مرة، نختار المستخدم الأول تلقائياً
          if (state is UserSuccess && _selectedUserId == null) {
            if (state.usersEntity.isNotEmpty) {
              setState(() {
                _selectedUserId = state.usersEntity.first.id;
              });
              // ونقوم بطلب عقود هذا المستخدم
              context.read<ContractCubit>().fetchContracts(userId: _selectedUserId!);
            }
          }
        },
        builder: (context, userState) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 300,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.cardColorDark
                    : AppColors.cardColorlight, // لون خلفية خفيف
                child: _buildUserList(userState),
              ),


              Expanded(
                child: _selectedUserId != null
                    ? ContractsViewBody(userId: _selectedUserId!)
                    : const Center(
                  child: Text("Select a user to view their contracts"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserList(UserState state) {
    if (state is UserLoading && _selectedUserId == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is UserFailure) {
      return Center(child: Text("Error: ${state.errMessage}"));
    }
    if (state is UserSuccess) {
      final users = state.usersEntity;
      if (users.isEmpty) {
        return const Center(child: Text("No users found."));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Users",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final isSelected = user.id == _selectedUserId;
                return Material(
                  color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedUserId = user.id;
                      });
                      // طلب تحديث العقود للمستخدم الجديد
                      context.read<ContractCubit>().fetchContracts(userId: user.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Text(user.username.substring(0, 1).toUpperCase()),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.username,
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  user.email,
                                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
    return const Center(child: Text("Select a user"));
  }
}
