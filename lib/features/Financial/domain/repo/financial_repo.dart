import 'package:dartz/dartz.dart';
import 'package:med_tech_admin/core/errors/failures.dart';
import '../../domain/entity/financial_entity.dart';

abstract class EarningsReportRepo {
  // ✅ الدالة الوحيدة التي نحتاجها
  Future<Either<Failure, EarningsReportEntity>> getEarningsReport({
    required DateTime startDate,
    required DateTime endDate,
  });
}
