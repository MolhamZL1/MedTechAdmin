import 'dart:ui';

enum PopupType {
  customer,
  product,
  status,
  date,
  orderSummary,
}

class PopupData {
  final PopupType type;
  final dynamic data;
  final Offset position;

  PopupData({
    required this.type,
    required this.data,
    required this.position,
  });
}

