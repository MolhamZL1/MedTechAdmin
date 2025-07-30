import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/rentaling/presentaion/widgets/dynamic_table.dart';
import 'package:med_tech_admin/features/users/presentation/cubits/user_cubit.dart';
import 'package:med_tech_admin/core/services/get_it_service.dart';
import 'package:med_tech_admin/features/users/domain/repos/user_repo.dart';
import 'package:med_tech_admin/features/users/presentation/views/widgets/user%20table%20helper.dart';
import 'HeaderUserView.dart';

class UserViewBody extends StatefulWidget {
  const UserViewBody({super.key});

  @override
  State<UserViewBody> createState() => _UserViewBodyState();
}

class _UserViewBodyState extends State<UserViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(getIt<UserRepo>())..fetchUsers(),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserSuccess) {
            final cubit = context.read<UserCubit>();
            final tableData = UserTableHelper.fromUserList(
              state.usersEntity,
              cubit,
              context,
            );
            return DynamicTable(tableData: tableData);
          } else if (state is UserFailure) {
            return const Center(child: Text('Failed to load users'));
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}
