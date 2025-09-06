import 'package:dartz/dartz.dart';
import 'package:med_tech_admin/core/errors/failures.dart';
import '../entities/contract-entity.dart';

abstract class ContractRepo {
  Future<Either<Failure, List<ContractEntity>>> getContracts({required int userId});

  // ✅✅✅ الدالة الجديدة ✅✅✅
  Future<Either<Failure, String>> updateContractStatus({
    required int orderItemId,
    required String newStatus,
  });
}
