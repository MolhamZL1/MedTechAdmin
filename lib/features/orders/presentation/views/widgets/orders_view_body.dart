import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/orders/presentation/views/widgets/tablehelper.dart';

import '../../../../../core/entities/InfoCardEntity.dart';
import '../../../../../core/services/get_it_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/const_variable.dart';
import '../../../../../core/widgets/show_err_dialog.dart';
import '../../../../../core/widgets/showsuccessDialog.dart';
import '../../../../rentaling/presentaion/widgets/dynamic_table.dart';
import '../../../domain/entities/order_entity.dart'; // استيراد الكيان الرئيسي
import '../../../domain/repos/order_repo.dart';
import '../cubits/cubit.dart';
import '../cubits/state.dart';
import 'HeaderOrdersView.dart';
import 'InformCardList.dart';

class OrderViewBody extends StatelessWidget {
  const OrderViewBody({super.key});

  // --- الخطوة 1: إنشاء دالة لحساب إحصائيات الطلبات ---
  List<InfoCardEntity> _generateInfoCards(List<OrderEntity> orders) {
    // حساب عدد الطلبات حسب الحالة
     pendingCount = orders.where((o) => o.status.toUpperCase() == 'PENDING').length;
    final processingCount = orders.where((o) => o.status.toUpperCase() == 'PROCESSING').length;
    final shippedCount = orders.where((o) => o.status.toUpperCase() == 'SHIPPED').length;
    final totalCount = orders.length;

    // حساب الإيرادات الإجمالية
    final totalRevenue = orders.fold<double>(0.0, (sum, order) {
      final total = order.totalAmount;
      if (total is num) {
        return sum + total;
      }
      return sum;
    });

    return [
      InfoCardEntity(
        text: "Total Orders",
        count: totalCount.toString(),
        icon: Icon(Icons.shopping_cart, size: 35),
      ),
      InfoCardEntity(
        color: AppColors.warning,
        text: "Pending Orders",
        count: pendingCount.toString(),
        icon: Icon(Icons.pending_actions, size: 35, color: AppColors.warning),
      ),
      InfoCardEntity(
        color: AppColors.darkGrey,
        text: "Processing Orders",
        count: processingCount.toString(),
        icon: Icon(Icons.sync, size: 35, color: AppColors.darkGrey),
      ),
      InfoCardEntity(
        color: AppColors.success,
        text: "Total Revenue",
        count: '\$${totalRevenue.toStringAsFixed(2)}',
        icon: Icon(Icons.monetization_on, size: 35, color: AppColors.success),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderCubit(getIt.get<OrderRepo>())..fetchOrders(),
      child: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is OrderStatusChanged) {
            showsuccessDialog(
              context: context,
              title: "Success",
              description: state.message,
            );
          } else if (state is OrderFailure) {
            if (state is! OrderStatusChanged) {
              showerrorDialog(
                context: context,
                title: "Error",
                description: state.errMessage,
              );
            }
          }
        },
        builder: (context, state) {
          // عرض مؤشر التحميل في جميع الحالات التي ليست نجاحًا أو فشلًا صريحًا
          if (state is! OrderSuccess && state is! OrderFailure) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading orders...'),
                ],
              ),
            );
          }

          // التعامل مع حالة الفشل
          if (state is OrderFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.errMessage}'),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.read<OrderCubit>().fetchOrders(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  )
                ],
              ),
            );
          }

          // حالة النجاح (OrderSuccess)
          final orders = (state as OrderSuccess).ordersEntity;
          final tableData = OrderTableHelper.fromOrderList(orders, context);

          // --- الخطوة 2: استدعاء الدالة للحصول على البيانات الديناميكية ---
          final List<InfoCardEntity> ordersListInfo = _generateInfoCards(orders);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- الخطوة 3: إضافة زر إعادة التحميل في الهيدر ---
                  HeaderOrdersView(
                    onRefresh: () {
                      context.read<OrderCubit>().fetchOrders();
                    },
                  ),
                  const SizedBox(height: 24),

                  // --- الخطوة 4: تمرير القائمة الديناميكية ---
                  InformCardList(entities: ordersListInfo),

                  const SizedBox(height: 24),
                  DynamicTable(
                    tableData: tableData,
                    enableSorting: true,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
