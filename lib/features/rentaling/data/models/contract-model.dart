
import '../../domain/entities/contract-entity.dart';

class ContractModel extends ContractEntity {
  const ContractModel({
    required int id,
    required String contractNumber,
    required int orderItemId,
    required int userId,
    required int productId,
    required String status,
    required DateTime startDate,
    required DateTime endDate,
    String? conditionOnDispatch,
    String? conditionOnReturn,
    DateTime? actualReturnDate,
    required DateTime agreedToTermsAt,
    required String contractDocumentUrl,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    required ContractUserModel user,
    required ContractProductModel product,
  }) : super(
    id: id,
    contractNumber: contractNumber,
    orderItemId: orderItemId,
    userId: userId,
    productId: productId,
    status: status,
    startDate: startDate,
    endDate: endDate,
    conditionOnDispatch: conditionOnDispatch,
    conditionOnReturn: conditionOnReturn,
    actualReturnDate: actualReturnDate,
    agreedToTermsAt: agreedToTermsAt,
    contractDocumentUrl: contractDocumentUrl,
    notes: notes,
    createdAt: createdAt,
    updatedAt: updatedAt,
    user: user,
    product: product,
  );

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      id: json["id"],
      contractNumber: json["contractNumber"],
      orderItemId: json["orderItemId"],
      userId: json["userId"],
      productId: json["productId"],
      status: json["status"],
      startDate: DateTime.parse(json["startDate"]),
      endDate: DateTime.parse(json["endDate"]),
      conditionOnDispatch: json["conditionOnDispatch"],
      conditionOnReturn: json["conditionOnReturn"],
      actualReturnDate: json["actualReturnDate"] != null
          ? DateTime.parse(json["actualReturnDate"])
          : null,
      agreedToTermsAt: DateTime.parse(json["agreedToTermsAt"]),
      contractDocumentUrl: json["contractDocumentUrl"],
      notes: json["notes"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      user: ContractUserModel.fromJson(json["user"]),
      product: ContractProductModel.fromJson(json["product"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "contractNumber": contractNumber,
      "orderItemId": orderItemId,
      "userId": userId,
      "productId": productId,
      "status": status,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String(),
      "conditionOnDispatch": conditionOnDispatch,
      "conditionOnReturn": conditionOnReturn,
      "actualReturnDate": actualReturnDate?.toIso8601String(),
      "agreedToTermsAt": agreedToTermsAt.toIso8601String(),
      "contractDocumentUrl": contractDocumentUrl,
      "notes": notes,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "user": (user as ContractUserModel).toJson(),
      "product": (product as ContractProductModel).toJson(),
    };
  }

  ContractEntity toEntity() {
    return ContractEntity(
      id: id,
      contractNumber: contractNumber,
      orderItemId: orderItemId,
      userId: userId,
      productId: productId,
      status: status,
      startDate: startDate,
      endDate: endDate,
      conditionOnDispatch: conditionOnDispatch,
      conditionOnReturn: conditionOnReturn,
      actualReturnDate: actualReturnDate,
      agreedToTermsAt: agreedToTermsAt,
      contractDocumentUrl: contractDocumentUrl,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
      user: user,
      product: product,
    );
  }
}

class ContractUserModel extends ContractUserEntity {
  const ContractUserModel({
    required int id,
    required String username,
    required String email,
  }) : super(
    id: id,
    username: username,
    email: email,
  );

  factory ContractUserModel.fromJson(Map<String, dynamic> json) {
    return ContractUserModel(
      id: json["id"],
      username: json["username"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
    };
  }

  ContractUserEntity toEntity() {
    return ContractUserEntity(
      id: id,
      username: username,
      email: email,
    );
  }
}

class ContractProductModel extends ContractProductEntity {
  const ContractProductModel({
    required int id,
    required String nameEn,
  }) : super(
    id: id,
    nameEn: nameEn,
  );

  factory ContractProductModel.fromJson(Map<String, dynamic> json) {
    return ContractProductModel(
      id: json["id"],
      nameEn: json["nameEn"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nameEn": nameEn,
    };
  }

  ContractProductEntity toEntity() {
    return ContractProductEntity(
      id: id,
      nameEn: nameEn,
    );
  }
}


