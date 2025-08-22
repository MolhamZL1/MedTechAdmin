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
}
