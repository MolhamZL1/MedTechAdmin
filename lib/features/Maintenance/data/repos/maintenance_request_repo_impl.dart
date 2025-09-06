import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_tech_admin/core/errors/failures.dart';
import 'package:med_tech_admin/core/services/database_service.dart';
import 'package:med_tech_admin/core/utils/backend_endpoints.dart';


import '../../domain/entities/maintenance_request_entity.dart';
import '../../domain/repos/maintenance_request_repo.dart';
import '../models/maintenance_request_model.dart';

class MaintenanceRequestRepoImpl implements MaintenanceRequestRepo {
  final DatabaseService databaseService;

  MaintenanceRequestRepoImpl({required this.databaseService});

  @override
  Future<Either<Failure, List<MaintenanceRequestEntity>>> getMaintenanceRequests() async {
    try {
      final response = await databaseService.getData(
        endpoint: BackendEndpoints.getMaintenanceRequests,
      );

      if (response is! List) {
        return Left(ServerFailure(
            errMessage: "Expected list of maintenance requests but got ${response.runtimeType}"));
      }

      final requests = response
          .map((e) => MaintenanceRequestModel.fromJson(e as Map<String, dynamic>).toEntity())
          .toList();

      return Right(requests);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> assignTechnicianToRequest({
  required int requestId,
  required int technicianId,
  required DateTime serviceDate,
  required double estimatedCost,
  }) async {
  try {
  final endpoint = "${BackendEndpoints.getMaintenanceRequest}/$requestId/assign-to-request";

  final response = await databaseService.patchData(
  endpoint: endpoint,
  data: {
  "technicianId": technicianId,
  "serviceDate": serviceDate.toIso8601String(),
  "estimatedCost": estimatedCost,
  },
  );

  if (response is Map && response.containsKey('message')) {
  return Right(response['message'] as String);
  } else {
  return Left(ServerFailure(errMessage: "Unexpected response from server."));
  }
  } catch (e) {
  if (e is DioException) {
  return Left(ServerFailure.fromDioError(e));
  }
  return Left(ServerFailure(errMessage: e.toString()));
  }
  }
  @override
  Future<Either<Failure, String>> completeMaintenanceRequest({
    required int requestId,
    required double finalCost,
    required String technicianNotes,
  }) async {
    try {
      final endpoint = "${BackendEndpoints.getMaintenanceRequest}/$requestId/complete-request";

      final response = await databaseService.patchData(
        endpoint: endpoint,
        data: {
          "finalCost": finalCost,
          "technicianNotes": technicianNotes,
        },
      );

      if (response is Map && response.containsKey('message')) {
        return Right(response['message'] as String);
      } else {
        return Left(ServerFailure(errMessage: "Unexpected response from server."));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

}


