import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/utils/backend_endpoints.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repos/order_repo.dart';
import '../model/order_model.dart';

class OrderRepoImp extends OrderRepo {
  final DatabaseService databaseService;

  OrderRepoImp({required this.databaseService});

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() async {
    try {
      final response = await databaseService.getData(
        endpoint: BackendEndpoints.getOrders,
      );

      if (response is! List) {
        return Left(ServerFailure(
            errMessage: "Expected list of orders but got ${response.runtimeType}"));
      }

      final orders = response
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>).toEntity())
          .toList();

      return Right(orders);
    } catch (e) {
      log(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> setOrderStatus(int orderId, String status) async {
    try {
      final response = await databaseService.patchData(
        endpoint: "${BackendEndpoints.setOrderStatus}/$orderId/set-status",
        data: {"status": status},
      );

      if (response is Map && response.containsKey("error")) {
        return Left(ServerFailure(errMessage: response["error"]));
      }

      return const Right(unit);
    } catch (e) {
      log("setOrderStatus error: $e");
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
  Future<Either<Failure, Unit>> confirmPayment(int orderId, double amount) async {
    try {
      final data = {
        "paymentMethod": "Cash on Delivery",
        "amountPaid": amount,
        // إنشاء ID فريد لكل عملية
        "transactionId": "COD-REF-${orderId}-${DateTime.now().millisecondsSinceEpoch}"
      };

      // بناء الرابط الكامل
      final endpoint = "${BackendEndpoints.confirmOrderPayment}/$orderId/confirm-payment";

      // استخدام addData لأنه يرسل طلب POST
      await databaseService.addData(endpoint: endpoint, data: data);

      return const Right(unit);
    } catch (e) {
      log("confirmPayment error: $e");
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
