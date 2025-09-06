import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';

class AppConstants {
  // ألوان الحالات
  static const Color activeColor = Color(0xFF10B981);
  static const Color expiresSoonColor = Color(0xFFF59E0B);
  static const Color overdueColor = Color(0xFFEF4444);
  static const Color completedColor = Color(0xFF10B981);

  // ألوان الخلفية
  static const Color primaryBackground = Color(0xFFF9FAFB);
  static const Color cardBackground = Colors.white;
  static const Color borderColor = Color(0xFFE5E7EB);

  // ألوان النص
  static const Color primaryText = Color(0xFF111827);
  static const Color secondaryText = Color(0xFF6B7280);
  static const Color accentText = Color(0xFF3B82F6);

  // أحجام الخط
  static const double headerFontSize = 14.0;
  static const double bodyFontSize = 14.0;
  static const double smallFontSize = 12.0;

  // المسافات
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // أبعاد الجدول
  static const double tableRowHeight = 80.0;
  static const double tableHeaderHeight = 50.0;
  static const double borderRadius = 8.0;
}


// --- الـ enum يحتوي على الحالات القديمة والجديدة معًا ---
enum StatusType {
  // الحالات القديمة
  active,
  expiresSoon,
  overdue,
  completed,

  // حالات الطلب الجديدة
  pending,
  paid,
  confirmed,
  shipped,
  delivered,
  cancelled,
  returned,
  unknown,
  approved,
  uncoming

}

extension StatusTypeExtension on StatusType {
  Color get color {
    switch (this) {
    // --- ربط الحالات القديمة ---
      case StatusType.active:
        return const Color(0xFF10B981); // Active Color
      case StatusType.expiresSoon:
        return const Color(0xFFF59E0B); // Expires Soon Color
      case StatusType.overdue:
        return const Color(0xFFEF4444); // Overdue Color
      case StatusType.completed:
        return AppColors.primary; // Completed Color

    // --- ربط حالات الطلب الجديدة ---
      case StatusType.pending:
        return AppColors.statusPending; // Orange
      case StatusType.paid:
      case StatusType.confirmed:
        return AppColors.statusConfirmed; // Blue
      case StatusType.shipped:
        return AppColors.statusShipped; // Purple
      case StatusType.delivered:
        return AppColors.statusDelivered; // Green
      case StatusType.cancelled:
        return AppColors.statusCancelled; // Red
      case StatusType.returned:
        return AppColors.warning;
      case StatusType.approved:
        return AppColors.warning;
      case StatusType.uncoming:
        return AppColors.error;
      case StatusType.unknown:
        return AppColors.statusDefault; // Grey
    }
  }

  IconData get icon {
    switch (this) {
    // --- أيقونات الحالات القديمة ---
      case StatusType.active:
        return Icons.check_circle;
      case StatusType.expiresSoon:
        return Icons.warning;
      case StatusType.overdue:
        return Icons.error;
      case StatusType.completed:
        return Icons.task_alt;

    // --- أيقونات حالات الطلب الجديدة ---
      case StatusType.pending:
        return Icons.hourglass_empty_rounded;
      case StatusType.paid:
      case StatusType.confirmed:
        return Icons.check_circle_outline_rounded;
      case StatusType.shipped:
        return Icons.local_shipping_rounded;
      case StatusType.delivered:
        return Icons.task_alt_rounded;
      case StatusType.cancelled:
        return Icons.cancel_rounded;
      case StatusType.returned:
        return Icons.assignment_return_rounded;
      case StatusType.approved:
        return Icons.assignment_return_rounded;
      case StatusType.uncoming:
        return Icons.question_mark;
      case StatusType.unknown:
        return Icons.help_outline_rounded;
    }
  }

  String get label {
    // تحويل اسم الـ enum إلى نص مقروء (مثال: 'expiresSoon' -> 'Expires Soon')
    final words = name.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
        .trim();
    return words[0].toUpperCase() + words.substring(1);
  }
}


