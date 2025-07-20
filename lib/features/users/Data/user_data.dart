import 'package:flutter/material.dart';

import '../../rentaling/utils/constants.dart';

enum UserRole {
  customer,
  technician,
  accountant,
  manager,
}

extension UserRoleExtension on UserRole {
  String get label {
    switch (this) {
      case UserRole.customer: return 'Customer';
      case UserRole.technician: return 'Technician';
      case UserRole.accountant: return 'Accountant';
      case UserRole.manager: return 'Manager';
    }
  }

  IconData get icon {
    switch (this) {
      case UserRole.customer: return Icons.person_outline;
      case UserRole.technician: return Icons.build_outlined;
      case UserRole.accountant: return Icons.attach_money_outlined;
      case UserRole.manager: return Icons.security_outlined;
    }
  }

  Color get color {
    switch (this) {
      case UserRole.customer: return AppConstants.primaryText;
      case UserRole.technician: return Colors.orange;
      case UserRole.accountant: return Colors.blue;
      case UserRole.manager: return Colors.purple;
    }
  }
}

class UserActivity {
  final DateTime lastActivityDate;
  final int? ordersCount;
  final double? totalAmount;

  const UserActivity({
    required this.lastActivityDate,
    this.ordersCount,
    this.totalAmount,
  });

  String get formattedLastActivityDate {
    return 'Last: ${lastActivityDate.year}-${lastActivityDate.month.toString().padLeft(2, '0')}-${lastActivityDate.day.toString().padLeft(2, '0')}';
  }

  String get formattedOrdersAndAmount {
    String text = '';
    if (ordersCount != null) {
      text += '${ordersCount!} orders';
    }
    if (totalAmount != null) {
      if (text.isNotEmpty) text += ' • ';
      text += '\$${totalAmount!.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]}',

      )}';
    }
    return text;
  }
}

class UserData {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final String hospital;
  final UserActivity activity;
  final StatusType status;

  const UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.hospital,
    required this.activity,
    required this.status,
  });

  String get initials {
    List<String> nameParts = name.split(' ');
    if (nameParts.length >= 2) {
      return (nameParts[0][0] + nameParts[1][0]).toUpperCase();
    } else if (nameParts.isNotEmpty) {
      return nameParts[0][0].toUpperCase();
    }
    return '';
  }
}

