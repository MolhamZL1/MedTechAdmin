// cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/orders/presentation/views/cubits/state.dart';
import '../../../domain/repos/order_repo.dart';
import '../../../domain/entities/order_entity.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo orderRepo;
  List<OrderEntity> _currentOrders = [];

  OrderCubit(this.orderRepo) : super(OrderInitial());

  Future<void> fetchOrders() async {
    print("CUBIT: Fetching orders..."); // <-- طباعة
    emit(OrderLoading());
    final result = await orderRepo.getOrders();
    result.fold(
          (failure) {
        print("CUBIT: Fetch failed: ${failure.errMessage}"); // <-- طباعة
        emit(OrderFailure(errMessage: failure.errMessage));
      },
          (orders) {
        print("CUBIT: Fetch successful. Got ${orders.length} orders."); // <-- طباعة
        _currentOrders = orders;
        emit(OrderSuccess(ordersEntity: orders));
      },
    );
  }

  Future<void> changeOrderStatus(int orderId, String newStatus) async {
    print("CUBIT: Attempting to change status for order $orderId to $newStatus"); // <-- طباعة

    final result = await orderRepo.setOrderStatus(orderId, newStatus);

    result.fold(
          (failure) {
        print("CUBIT: Change status FAILED: ${failure.errMessage}"); // <-- طباعة
        emit(OrderFailure(errMessage: failure.errMessage));
        emit(OrderSuccess(ordersEntity: _currentOrders));
      },
          (successResponse) {
        final successMessage = (successResponse as Map)['message'] ?? "Order status updated successfully";
        print("CUBIT: Change status API call successful. Message: $successMessage"); // <-- طباعة

        final orderIndex = _currentOrders.indexWhere((order) => order.id == orderId);
        if (orderIndex != -1) {
          _currentOrders[orderIndex] = _currentOrders[orderIndex].copyWith(status: newStatus);
          print("CUBIT: Local order list updated."); // <-- طباعة
        }

        print("CUBIT: Emitting OrderStatusChanged..."); // <-- طباعة
        emit(OrderStatusChanged(message: successMessage));

        print("CUBIT: Emitting OrderSuccess with updated list..."); // <-- طباعة
        emit(OrderSuccess(ordersEntity: List.from(_currentOrders)));
      },
    );
  }
  Future<void> confirmOrderPayment(int orderId, double amount) async {
    // يمكنك إظهار حالة تحميل إذا أردت
    // emit(OrderLoading());

    final result = await orderRepo.confirmPayment(orderId, amount);

    result.fold(
          (failure) {
        // عرض رسالة الخطأ
        emit(OrderFailure(errMessage: failure.errMessage));
        // إعادة عرض القائمة الأصلية
        emit(OrderSuccess(ordersEntity: _currentOrders));
      },
          (_) {
        // عند النجاح، قم بتحديث حالة الطلب محلياً إلى "PAID"
        final orderIndex = _currentOrders.indexWhere((order) => order.id == orderId);
        if (orderIndex != -1) {
          _currentOrders[orderIndex] = _currentOrders[orderIndex].copyWith(status: 'PAID');
        }

        // عرض رسالة النجاح وتحديث الواجهة
        emit(OrderStatusChanged(message: "Payment confirmed successfully!"));
        emit(OrderSuccess(ordersEntity: List.from(_currentOrders)));
      },
    );
  }
}
