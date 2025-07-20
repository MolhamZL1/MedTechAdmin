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

enum StatusType {
  active,
  expiresSoon,
  overdue,
  completed,
  suspended,
}

extension StatusTypeExtension on StatusType {
  Color get color {
    switch (this) {
      case StatusType.active:
        return AppConstants.activeColor;
      case StatusType.expiresSoon:
        return AppConstants.expiresSoonColor;
      case StatusType.overdue:
        return AppConstants.overdueColor;
      case StatusType.completed:
        return AppColors.primary;
      case StatusType.suspended:
        return AppColors.error;

    }
  }
  IconData get icon {
    switch (this) {
      case StatusType.active:
        return Icons.check_circle;
      case StatusType.expiresSoon:
        return Icons.warning;
      case StatusType.overdue:
        return Icons.error;
      case StatusType.completed:
        return Icons.task_alt;
      case StatusType.suspended:
        return Icons.phonelink_erase_rounded;
    }
  }

  String get label {
    switch (this) {
      case StatusType.active:
        return 'Active';
      case StatusType.expiresSoon:
        return 'Expires Soon';
      case StatusType.overdue:
        return 'Overdue';
      case StatusType.completed:
        return 'Completed';
      case StatusType.suspended:
        return 'suspended';
    }
  }
}

