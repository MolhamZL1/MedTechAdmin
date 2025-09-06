import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repos/contract_repo.dart';
import 'contract_state.dart';

class ContractCubit extends Cubit<ContractState> {
  final ContractRepo contractRepo;
  int? _currentUserId; // لتخزين ID المستخدم الحالي

  ContractCubit(this.contractRepo) : super(ContractInitial());

  Future<void> fetchContracts({required int userId}) async {
    _currentUserId = userId; // تخزين الـ ID
    emit(ContractLoading());
    final result = await contractRepo.getContracts(userId: userId);
    result.fold(
          (failure) => emit(ContractFailure(failure.errMessage)),
          (contracts) => emit(ContractSuccess(contracts)),
    );
  }

  // ✅✅✅ الدالة الجديدة ✅✅✅
  Future<void> updateStatus({
    required int orderItemId,
    required String newStatus,
  }) async {
    emit(ContractStatusUpdateLoading());
    final result = await contractRepo.updateContractStatus(
      orderItemId: orderItemId,
      newStatus: newStatus,
    );

    result.fold(
          (failure) => emit(ContractStatusUpdateFailure(failure.errMessage)),
          (successMessage) {
        emit(ContractStatusUpdateSuccess(successMessage));
        // إعادة جلب العقود لنفس المستخدم لتحديث الواجهة
        if (_currentUserId != null) {
          fetchContracts(userId: _currentUserId!);
        }
      },
    );
  }
}
