import '../../domain/entities/maintenance_request_entity.dart';

class MaintenanceRequestModel extends MaintenanceRequestEntity {
  const MaintenanceRequestModel({
    required super.id,
    required super.requestNumber,
    required super.customerId,
    super.technicianId,
    required super.productId,
    required super.status,
    required super.issueDescription,
    required super.preferredServiceDate,
    super.serviceDate,
    super.estimatedCost,
    super.finalCost,
    super.technicianNotes,
    required super.createdAt,
    required super.updatedAt,
    super.usersId,
    required super.customer,
    super.technician,
    required super.product,
  });

  factory MaintenanceRequestModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceRequestModel(
      id: json['id'],
      requestNumber: json['requestNumber'],
      customerId: json['customerId'],
      technicianId: json['technicianId'],
      productId: json['productId'],
      status: json['status'],
      issueDescription: json['issueDescription'],
      preferredServiceDate: DateTime.parse(json['preferredServiceDate']),
      serviceDate: json['serviceDate'] != null ? DateTime.parse(json['serviceDate']) : null,
      estimatedCost: (json['estimatedCost'] as num?)?.toDouble(),
      finalCost: (json['finalCost'] as num?)?.toDouble(),
      technicianNotes: json['technicianNotes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      usersId: json['usersId'],
      customer: MaintenanceRequestCustomerModel.fromJson(json['customer']),
      technician: json['technician'] != null ? MaintenanceRequestTechnicianModel.fromJson(json['technician']) : null,
      product: MaintenanceRequestProductModel.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "requestNumber": requestNumber,
      "customerId": customerId,
      "technicianId": technicianId,
      "productId": productId,
      "status": status,
      "issueDescription": issueDescription,
      "preferredServiceDate": preferredServiceDate.toIso8601String(),
      "serviceDate": serviceDate?.toIso8601String(),
      "estimatedCost": estimatedCost,
      "finalCost": finalCost,
      "technicianNotes": technicianNotes,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "usersId": usersId,
      "customer": (customer as MaintenanceRequestCustomerModel).toJson(),
      "technician": (technician as MaintenanceRequestTechnicianModel?)?.toJson(),
      "product": (product as MaintenanceRequestProductModel).toJson(),
    };
  }

  MaintenanceRequestEntity toEntity() {
    return this;
  }
}

class MaintenanceRequestCustomerModel extends MaintenanceRequestCustomerEntity {
  const MaintenanceRequestCustomerModel({
    required super.id,
    required super.username,
    required super.email,
  });

  factory MaintenanceRequestCustomerModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceRequestCustomerModel(
      id: json["id"],
      username: json["username"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "username": username, "email": email};
  }

  MaintenanceRequestCustomerEntity toEntity() {
    return this;
  }
}

class MaintenanceRequestTechnicianModel extends MaintenanceRequestTechnicianEntity {
  const MaintenanceRequestTechnicianModel({
    required super.id,
    required super.username,
  });

  factory MaintenanceRequestTechnicianModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceRequestTechnicianModel(
      id: json["id"],
      username: json["username"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "username": username};
  }

  MaintenanceRequestTechnicianEntity toEntity() {
    return this;
  }
}

class MaintenanceRequestProductModel extends MaintenanceRequestProductEntity {
  const MaintenanceRequestProductModel({
    required super.id,
    required super.nameEn,
  });

  factory MaintenanceRequestProductModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceRequestProductModel(
      id: json["id"],
      nameEn: json["nameEn"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "nameEn": nameEn};
  }

  MaintenanceRequestProductEntity toEntity() {
    return this;
  }
}
