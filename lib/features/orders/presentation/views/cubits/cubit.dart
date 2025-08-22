import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/orders/presentation/views/cubits/state.dart';
import 'package:meta/meta.dart';

import '../../../domain/repos/order_repo.dart';


class OrderCubit extends Cubit<OrderState> {
  final OrderRepo orderRepo;

  OrderCubit(this.orderRepo) : super(OrderInitial());

  Future<void> fetchOrders() async {
    emit(OrderLoading());
    final result = await orderRepo.getOrders();
    result.fold(
          (failure) => emit(OrderFailure(errMessage: failure.errMessage)), // ✅ اسم باراميتر
          (orders) => emit(OrderSuccess(ordersEntity: orders)),            // ✅ اسم باراميتر
    );
  }
}
