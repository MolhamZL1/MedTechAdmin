
class Order {
  final String orderId;
  final String customerName;
  final String customerCity;
  final String customerEmail;
  final String customerPhone;
  final String customerAddress;
  final String productName;
  final int productQuantity;
  final double total;
  final String status;
  final String orderDate;
  final String estimatedDelivery;
  final String paymentMethod;
  final String notes;
  final double productPrice;

  Order({
    required this.orderId,
    required this.customerName,
    required this.customerCity,
    required this.customerEmail,
    required this.customerPhone,
    required this.customerAddress,
    required this.productName,
    required this.productQuantity,
    required this.total,
    required this.status,
    required this.orderDate,
    required this.estimatedDelivery,
    required this.paymentMethod,
    required this.notes,
    required this.productPrice,
  });

}



