import 'package:flutter/foundation.dart';

class ContractEntity {
  final int id;
  final String contractNumber;
  final int orderItemId;
  final int userId;
  final int productId;
  final String status;
  final DateTime startDate;
  final DateTime endDate;
  final String? conditionOnDispatch;
  final String? conditionOnReturn;
  final DateTime? actualReturnDate;
  final DateTime agreedToTermsAt;
  final String contractDocumentUrl;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ContractUserEntity user;
  final ContractProductEntity product;

  const ContractEntity({
    required this.id,
    required this.contractNumber,
    required this.orderItemId,
    required this.userId,
    required this.productId,
    required this.status,
    required this.startDate,
    required this.endDate,
    this.conditionOnDispatch,
    this.conditionOnReturn,
    this.actualReturnDate,
    required this.agreedToTermsAt,
    required this.contractDocumentUrl,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.product,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ContractEntity &&
      other.id == id &&
      other.contractNumber == contractNumber &&
      other.orderItemId == orderItemId &&
      other.userId == userId &&
      other.productId == productId &&
      other.status == status &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.conditionOnDispatch == conditionOnDispatch &&
      other.conditionOnReturn == conditionOnReturn &&
      other.actualReturnDate == actualReturnDate &&
      other.agreedToTermsAt == agreedToTermsAt &&
      other.contractDocumentUrl == contractDocumentUrl &&
      other.notes == notes &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.user == user &&
      other.product == product;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      contractNumber.hashCode ^
      orderItemId.hashCode ^
      userId.hashCode ^
      productId.hashCode ^
      status.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      conditionOnDispatch.hashCode ^
      conditionOnReturn.hashCode ^
      actualReturnDate.hashCode ^
      agreedToTermsAt.hashCode ^
      contractDocumentUrl.hashCode ^
      notes.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      user.hashCode ^
      product.hashCode;
  }
}

class ContractUserEntity {
  final int id;
  final String username;
  final String email;

  const ContractUserEntity({
    required this.id,
    required this.username,
    required this.email,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ContractUserEntity &&
      other.id == id &&
      other.username == username &&
      other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ email.hashCode;
}

class ContractProductEntity {
  final int id;
  final String nameEn;

  const ContractProductEntity({
    required this.id,
    required this.nameEn,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ContractProductEntity &&
      other.id == id &&
      other.nameEn == nameEn;
  }

  @override
  int get hashCode => id.hashCode ^ nameEn.hashCode;
}


