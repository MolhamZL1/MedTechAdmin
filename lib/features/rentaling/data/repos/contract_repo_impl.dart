import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_tech_admin/core/errors/failures.dart';
import 'package:med_tech_admin/core/services/database_service.dart';
import '../../domain/entities/contract-entity.dart';
import '../../domain/repos/contract_repo.dart';
import '../models/contract-model.dart';
import '../../../../core/utils/backend_endpoints.dart';

class ContractRepoImpl implements ContractRepo {
  final DatabaseService databaseService;

  ContractRepoImpl({required this.databaseService});

  @override
  Future<Either<Failure, List<ContractEntity>>> getContracts(
      {required int userId}) async {
    try {
      final response = await databaseService.getData(
        endpoint: BackendEndpoints.getContracts,
        quary: {'userId': userId.toString()},
      );

      if (response is! List) {
        return Left(ServerFailure(
            errMessage: "Expected list of contracts but got ${response
                .runtimeType}"));
      }

      final contracts = response
          .map((e) =>
          ContractModel.fromJson(e as Map<String, dynamic>).toEntity())
          .toList();

      return Right(contracts);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  // ✅✅✅ تنفيذ الدالة الجديدة ✅✅✅
  @override
  Future<Either<Failure, String>> updateContractStatus({
    required int orderItemId,
    required String newStatus,
  }) async {
    try {
      final endpoint = "${BackendEndpoints
          .updateContractStatus}/$orderItemId/update-contract-status";
      final response = await databaseService.patchData(
        endpoint: endpoint,
        data: {'status': newStatus},
      );

      if (response is Map && response.containsKey('message')) {
        return Right(response['message'] as String);
      } else {
        return Left(
            ServerFailure(errMessage: "Unexpected response from server."));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> returnRentedItem({
    required int orderItemId,
    required String condition,
    String? notes,
  }) async {
    try {
      final endpoint = "${BackendEndpoints
          .returnRentedItem}/$orderItemId/return-rented";
      final response = await databaseService.addData(
        endpoint: endpoint,
        data: {
          'conditionOnReturn': condition,
          'notes': notes,
        },
      );

      if (response is Map && response.containsKey('message')) {
        return Right(response['message'] as String);
      } else {
        return Left(
            ServerFailure(errMessage: "Unexpected response from server."));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
