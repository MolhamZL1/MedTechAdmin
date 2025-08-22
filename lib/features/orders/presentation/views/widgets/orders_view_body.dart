import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/orders/presentation/views/widgets/tablehelper.dart';
import '../../../domain/repos/order_repo.dart';
import '../../../../../core/services/get_it_service.dart';
import '../../../../rentaling/presentaion/widgets/dynamic_table.dart';
import '../../../../rentaling/domain/table_data.dart';
import '../../../../rentaling/utils/constants.dart';
import '../cubits/cubit.dart';

import '../cubits/state.dart';
import 'HeaderOrdersView.dart';
import 'InformCardList.dart';
import '../../../../../core/entities/InfoCardEntity.dart';

class OrderViewBody extends StatelessWidget {
  const OrderViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderCubit(getIt.get<OrderRepo>())..fetchOrders(),
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderSuccess) {
            final tableData = OrderTableHelper.fromOrderList(state.orders,context);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderOrdersView(),
                    const SizedBox(height: 24),
                    InformCardList(entities: orderslistinfo), // لو عندك info cards
                    const SizedBox(height: 24),
                    DynamicTable(
                      tableData: tableData,
                      enableSorting: true,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is OrderFailure) {
            return Center(child: Text('Error: ${state.errMessage}'));
          }
          return const Center(child: Text('No data yet'));
        },
      ),
    );
  }
}
