import 'package:flutter/material.dart';

class AppHelpers {
  /// Format currency with commas
  static String formatCurrency(double amount, {String symbol = '\$'}) {
    return '$symbol${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    )}';
  }

  /// Calculate processing time between two dates
  static String calculateProcessingTime(String startDate, String endDate) {
    try {
      final start = DateTime.parse(startDate);
      final end = DateTime.parse(endDate);
      final difference = end.difference(start).inDays;
      return '$difference days';
    } catch (e) {
      return 'N/A';
    }
  }

  /// Get status color based on status string
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'processing':
        return Colors.white;
      case 'shipped':
        return Colors.white;
      case 'delivered':
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  /// Get status icon based on status string
  static IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'processing':
        return Icons.access_time;
      case 'shipped':
        return Icons.local_shipping;
      case 'delivered':
        return Icons.check_circle;
      default:
        return Icons.help_outline;
    }
  }

  /// Calculate popup position to ensure it stays within screen bounds
  static Offset calculatePopupPosition({
    required BuildContext context,
    required Offset tapPosition,
    required Size popupSize,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final margin = 20.0;

    double left = tapPosition.dx;
    double top = tapPosition.dy - popupSize.height / 2;

    // Ensure popup doesn't go off the right edge
    if (left + popupSize.width > screenSize.width - margin) {
      left = screenSize.width - popupSize.width - margin;
    }

    // Ensure popup doesn't go off the left edge
    if (left < margin) {
      left = margin;
    }

    // Ensure popup doesn't go off the bottom edge
    if (top + popupSize.height > screenSize.height - margin) {
      top = screenSize.height - popupSize.height - margin;
    }

    // Ensure popup doesn't go off the top edge
    if (top < margin) {
      top = margin;
    }

    return Offset(left, top);
  }

  /// Truncate text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  /// Validate email format
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Validate phone format
  static bool isValidPhone(String phone) {
    return RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(phone);
  }
}

