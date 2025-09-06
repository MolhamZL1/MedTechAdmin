import 'package:flutter/material.dart';

abstract class AppColors {
  // الألوان الأساسية
  static const Color primary = Color(0xFF2563eb);
  static const Color warning = Color(0xFFc98b02);
  static const Color success = Color(0xFF3ea659);
  static const Color error = Color(0xFFd84b39);

  // ألوان البطاقات
  static const Color cardColorlight = Colors.white;
  static const Color cardColorDark = Color(0xFF1e293b);

  // لون النص الأساسي
  static const Color textColor = Color(0xFF0c1a47);

  // ألوان إضافية لواجهة المستخدم
  static const Color lightGrey = Color(0xFFf1f5f9); // (grey.shade100)
  static const Color mediumGrey = Color(0xFFcbd5e1); // (grey.shade300)
  static const Color darkGrey = Color(0xFF475569);   // (grey.shade600)

  // ألوان حالات الطلب
  static const Color statusPending = Colors.orange;
  static const Color statusConfirmed = Colors.blue;
  static const Color statusShipped = Colors.purple;
  static const Color statusDelivered = Colors.green;
  static const Color statusCancelled = Colors.red;
  static const Color statusDefault = Colors.grey;

  // ألوان خاصة بالـ Dialog
  static const Color dialogHeaderColor = Color(0xFFe0f2fe); // (blue.shade50)
  static const Color dialogIconColor = Colors.blue;
  static  const int totalCount=0;
}
