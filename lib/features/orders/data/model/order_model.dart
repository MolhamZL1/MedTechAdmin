import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.id,
    required super.userId,
    required super.status,
    required super.totalAmount,
    required super.shippingAddress,
    required super.createdAt,
    required super.updatedAt,
    required super.user,
    super.items = const [],
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['userId'],
      status: json['status'],
      totalAmount: (json['totalAmount'] as num).toDouble(),
      shippingAddress: json['shippingAddress'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: OrderUserModel.fromJson(json['user']),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "status": status,
    "totalAmount": totalAmount,
    "shippingAddress": shippingAddress,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "user": (user as OrderUserModel).toJson(),
    "items": items.map((e) => (e as OrderItemModel).toJson()).toList(),
  };

  OrderEntity toEntity() => this;
}

class OrderUserModel extends OrderUserEntity {
  OrderUserModel({
    required super.id,
    required super.username,
    required super.email,
  });

  factory OrderUserModel.fromJson(Map<String, dynamic> json) {
    return OrderUserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
  };

  OrderUserEntity toEntity() => this;
}

class OrderItemModel extends OrderItemEntity {
  OrderItemModel({
    required super.id,
    required super.orderId,
    required super.productId,
    required super.quantity,
    required super.transactionType,
    required super.priceAtTimeOfTransaction,
    super.rentalStartDate,
    super.rentalEndDate,
    super.returnDate,
    required super.product,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      orderId: json['orderId'],
      productId: json['productId'],
      quantity: json['quantity'],
      transactionType: json['transactionType'],
      priceAtTimeOfTransaction: (json['priceAtTimeOfTransaction'] as num).toDouble(),
      rentalStartDate: json['rentalStartDate'] != null ? DateTime.parse(json['rentalStartDate']) : null,
      rentalEndDate: json['rentalEndDate'] != null ? DateTime.parse(json['rentalEndDate']) : null,
      returnDate: json['returnDate'] != null ? DateTime.parse(json['returnDate']) : null,
      product: OrderProductModel.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "orderId": orderId,
    "productId": productId,
    "quantity": quantity,
    "transactionType": transactionType,
    "priceAtTimeOfTransaction": priceAtTimeOfTransaction,
    "rentalStartDate": rentalStartDate?.toIso8601String(),
    "rentalEndDate": rentalEndDate?.toIso8601String(),
    "returnDate": returnDate?.toIso8601String(),
    "product": (product as OrderProductModel).toJson(),
  };

  OrderItemEntity toEntity() => this;
}

class OrderProductModel extends OrderProductEntity {
  OrderProductModel({
    required super.nameEn,
    required super.nameAr,
    super.imageUrl,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      nameEn: json['nameEn'],
      nameAr: json['nameAr'],
      imageUrl: json['imageUrl'], // optional
    );
  }

  Map<String, dynamic> toJson() => {
    "nameEn": nameEn,
    "nameAr": nameAr,
    "imageUrl": imageUrl,
  };

  OrderProductEntity toEntity() => this;
}
