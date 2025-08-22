
import '../../../domain/entities/order_entity.dart';


sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderFailure extends OrderState {
  final String errMessage;
  OrderFailure({required this.errMessage});
}

final class OrderSuccess extends OrderState {
  final List<OrderEntity> ordersEntity;

  // ✅ هذا بيخلي state.orders يشتغل بدون ما تغيّري الواجهة
  List<OrderEntity> get orders => ordersEntity;

  OrderSuccess({required this.ordersEntity});
}
