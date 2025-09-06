import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/maintenance_request_entity.dart';

abstract class MaintenanceRequestRepo {
  Future<Either<Failure, List<MaintenanceRequestEntity>>> getMaintenanceRequests();

  // ✅✅✅ تعديل الدالة لتقبل كل البيانات ✅✅✅
  Future<Either<Failure, String>> assignTechnicianToRequest({
    required int requestId,
    required int technicianId,
    required DateTime serviceDate,
    required double estimatedCost,
  });
  Future<Either<Failure, String>> completeMaintenanceRequest({
    required int requestId,
    required double finalCost,
    required String technicianNotes,
  });
}
