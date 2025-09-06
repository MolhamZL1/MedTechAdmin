import '../../domain/entities/maintenance_request_entity.dart';

abstract class MaintenanceRequestState {}

class MaintenanceRequestInitial extends MaintenanceRequestState {}

class MaintenanceRequestLoading extends MaintenanceRequestState {}

class MaintenanceRequestSuccess extends MaintenanceRequestState {
  final List<MaintenanceRequestEntity> requests;

  MaintenanceRequestSuccess(this.requests);
}

class MaintenanceRequestFailure extends MaintenanceRequestState {
  final String errMessage;

  MaintenanceRequestFailure(this.errMessage);
}

class AssigningTechnician extends MaintenanceRequestState {}

class AssignTechnicianSuccess extends MaintenanceRequestState {
  final String successMessage;
  AssignTechnicianSuccess(this.successMessage);
}

class AssignTechnicianFailure extends MaintenanceRequestState {
  final String errMessage;
  AssignTechnicianFailure(this.errMessage);
}
// ... (الحالات الحالية تبقى كما هي)

// ✅✅✅ أضف هذه الحالات الثلاث الجديدة ✅✅✅

/// حالة تدل على أن عملية إكمال الطلب جارية.
class CompletingRequest extends MaintenanceRequestState {}

/// حالة تدل على أن عملية إكمال الطلب نجحت.
class CompleteRequestSuccess extends MaintenanceRequestState {
  final String successMessage;
  CompleteRequestSuccess(this.successMessage);
}

/// حالة تدل على أن عملية إكمال الطلب فشلت.
class CompleteRequestFailure extends MaintenanceRequestState {
  final String errMessage;
  CompleteRequestFailure(this.errMessage);
}
