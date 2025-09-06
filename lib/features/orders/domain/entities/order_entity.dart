// انسخ هذا الكود بالكامل والصقه في ملف order_entity.dart

class OrderEntity {
  final int id;
  final int userId;
  final String status;
  final double totalAmount;
  // --- ✅ التعديل الأول: السماح بأن يكون العنوان null ---
  final String? shippingAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final OrderUserEntity user;
  final List<OrderItemEntity> items;

  OrderEntity({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    this.shippingAddress, // <-- جعله اختيارياً في الكونستركتور
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    this.items = const [],
  });

  // --- ✅ التعديل الثاني: تحديث دالة copyWith ---
  OrderEntity copyWith({
    int? id,
    int? userId,
    String? status,
    double? totalAmount,
    String? shippingAddress,
    DateTime? createdAt,
    DateTime? updatedAt,
    OrderUserEntity? user,
    List<OrderItemEntity>? items,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      // هنا نستخدم this.shippingAddress للسماح بإعادة القيمة الحالية (سواء كانت نصاً أو null)
      shippingAddress: shippingAddress ?? this.shippingAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      items: items ?? this.items,
    );
  }
}

// باقي الكلاسات في هذا الملف لا تحتاج تعديل
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
