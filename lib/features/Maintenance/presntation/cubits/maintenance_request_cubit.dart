import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repos/maintenance_request_repo.dart';
import 'maintenance_request_state.dart';

class MaintenanceRequestCubit extends Cubit<MaintenanceRequestState> {
  final MaintenanceRequestRepo maintenanceRequestRepo;

  MaintenanceRequestCubit(this.maintenanceRequestRepo) : super(MaintenanceRequestInitial());

  Future<void> fetchMaintenanceRequests() async {
    emit(MaintenanceRequestLoading());
    final result = await maintenanceRequestRepo.getMaintenanceRequests();
    result.fold(
      (failure) => emit(MaintenanceRequestFailure(failure.errMessage)),
      (requests) => emit(MaintenanceRequestSuccess(requests)),
    );
  }
  Future<void> assignTechnician({
    required int requestId,
    required int technicianId,
    required DateTime serviceDate,
    required double estimatedCost,
  }) async {
    emit(AssigningTechnician());

    final result = await maintenanceRequestRepo.assignTechnicianToRequest(
      requestId: requestId,
      technicianId: technicianId,
      serviceDate: serviceDate,
      estimatedCost: estimatedCost,
    );

    result.fold(
          (failure) {
        emit(AssignTechnicianFailure(failure.errMessage));
        fetchMaintenanceRequests();
      },
          (successMessage) {
        emit(AssignTechnicianSuccess(successMessage));
        fetchMaintenanceRequests();
      },
    );}
  Future<void> completeRequest({
    required int requestId,
    required double finalCost,
    required String technicianNotes,
  }) async {
    emit(CompletingRequest());

    final result = await maintenanceRequestRepo.completeMaintenanceRequest(
      requestId: requestId,
      finalCost: finalCost,
      technicianNotes: technicianNotes,
    );

    result.fold(
          (failure) {
        emit(CompleteRequestFailure(failure.errMessage));
        fetchMaintenanceRequests(); // أعد التحميل لتحديث الواجهة
      },
          (successMessage) {
        emit(CompleteRequestSuccess(successMessage));
        fetchMaintenanceRequests(); // أعد التحميل لتحديث الواجهة
      },
    );
  }
}


