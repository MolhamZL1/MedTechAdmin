import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:med_tech_admin/core/errors/failures.dart';
import 'package:med_tech_admin/core/services/database_service.dart';
import 'package:med_tech_admin/core/utils/backend_endpoints.dart';
import '../../domain/entity/financial_entity.dart';
import '../../domain/repo/financial_repo.dart';
import '../model/financial_model.dart';

class EarningsReportRepoImpl implements EarningsReportRepo {
  final DatabaseService databaseService;
  EarningsReportRepoImpl({required this.databaseService});

  @override
  Future<Either<Failure, EarningsReportEntity>> getEarningsReport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final formatter = DateFormat('yyyy-MM-dd');
      final response = await databaseService.getData(
        endpoint: BackendEndpoints.getEarningsReport,
        quary: {
          'startDate': formatter.format(startDate),
          'endDate': formatter.format(endDate),
        },
      );
      return Right(EarningsReportModel.fromJson(response).toEntity());
    } catch (e) {
      if (e is DioException) return Left(ServerFailure.fromDioError(e));
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
