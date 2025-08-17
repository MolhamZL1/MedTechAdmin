import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/users/domain/entities/user-entity.dart';
import 'package:med_tech_admin/features/users/presentation/views/widgets/HeaderUserView.dart';

import '../../../../../core/entities/InfoCardEntity.dart';
import '../../../../../core/services/get_it_service.dart';
import '../../../../orders/presentation/views/widgets/InformCardList.dart';
import '../../../../rentaling/presentaion/widgets/dynamic_table.dart';
import '../../../Data/models/user_model.dart';
import '../../../domain/repos/user_repo.dart';
import 'user table helper.dart';
import '../../cubits/user_cubit.dart';

class UserViewBody extends StatelessWidget {
  const UserViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(getIt.get<UserRepo>())..fetchUsers(),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center();
          } else if (state is UserSuccess) {
            final cubit = BlocProvider.of<UserCubit>(context);
            final tableData = UserTableHelper.fromUserList(state.usersEntity, cubit,context);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    HeaderUsersView(),
                    const SizedBox(height: 24),
                    InformCardList(entities: Userslistinfo),
                    const SizedBox(height: 24),
                    DynamicTable(
                      tableData: tableData,
                      enableSorting: true,
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
