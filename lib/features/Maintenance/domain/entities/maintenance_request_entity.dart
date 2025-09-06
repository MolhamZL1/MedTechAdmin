import 'package:equatable/equatable.dart';

class MaintenanceRequestEntity extends Equatable {
  final int id;
  final String requestNumber;
  final int customerId;
  final int? technicianId;
  final int productId;
  final String status;
  final String issueDescription;
  final DateTime preferredServiceDate;
  final DateTime? serviceDate;
  final double? estimatedCost;
  final double? finalCost;
  final String? technicianNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? usersId;
  final MaintenanceRequestCustomerEntity customer;
  final MaintenanceRequestTechnicianEntity? technician;
  final MaintenanceRequestProductEntity product;

  const MaintenanceRequestEntity({
    required this.id,
    required this.requestNumber,
    required this.customerId,
    this.technicianId,
    required this.productId,
    required this.status,
    required this.issueDescription,
    required this.preferredServiceDate,
    this.serviceDate,
    this.estimatedCost,
    this.finalCost,
    this.technicianNotes,
    required this.createdAt,
    required this.updatedAt,
    this.usersId,
    required this.customer,
    this.technician,
    required this.product,
  });

  @override
  List<Object?> get props => [id, requestNumber, status, customer, product, createdAt, updatedAt];
}

class MaintenanceRequestCustomerEntity extends Equatable {
  final int id;
  final String username;
  final String email;

  const MaintenanceRequestCustomerEntity({
    required this.id,
    required this.username,
    required this.email,
  });

  @override
  List<Object?> get props => [id, username, email];
}

class MaintenanceRequestTechnicianEntity extends Equatable {
  final int id;
  final String username;
  // ملاحظة: الـ JSON لا يحتوي على email للفني، لذلك تم حذفه من هنا
  const MaintenanceRequestTechnicianEntity({
    required this.id,
    required this.username,
  });

  @override
  List<Object?> get props => [id, username];
}

class MaintenanceRequestProductEntity extends Equatable {
  final int id;
  final String nameEn;

  const MaintenanceRequestProductEntity({
    required this.id,
    required this.nameEn,
  });

  @override
  List<Object?> get props => [id, nameEn];
}
