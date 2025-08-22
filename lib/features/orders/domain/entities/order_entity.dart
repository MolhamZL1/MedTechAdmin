class OrderEntity {
  final int id;
  final int userId;
  final String status;
  final double totalAmount;
  final String shippingAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final OrderUserEntity user;
  final List<OrderItemEntity> items; // ← أضفنا items

  OrderEntity({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.shippingAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    this.items = const [], // default empty list
  });
}

class OrderUserEntity {
  final int id;
  final String username;
  final String email;

  OrderUserEntity({
    required this.id,
    required this.username,
    required this.email,
  });
}

class OrderItemEntity {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final String transactionType;
  final double priceAtTimeOfTransaction;
  final DateTime? rentalStartDate;
  final DateTime? rentalEndDate;
  final DateTime? returnDate;
  final OrderProductEntity product;

  OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.transactionType,
    required this.priceAtTimeOfTransaction,
    this.rentalStartDate,
    this.rentalEndDate,
    this.returnDate,
    required this.product,
  });
}

class OrderProductEntity {
  final String nameEn;
  final String nameAr;
  final String? imageUrl;

  OrderProductEntity({
    required this.nameEn,
    required this.nameAr,
    this.imageUrl,
  });
}
