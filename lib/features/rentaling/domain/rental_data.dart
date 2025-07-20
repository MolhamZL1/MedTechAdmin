import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Customer {
  final String name;
  final String organization;
  final String? email;
  final String? phone;
  final String? address;

  const Customer({
    required this.name,
    required this.organization,
    this.email,
    this.phone,
    this.address,
  });

  @override
  String toString() => '$name\n$organization';
}

class RentalPeriod {
  final DateTime startDate;
  final DateTime endDate;
  final String? additionalInfo;

  const RentalPeriod({
    required this.startDate,
    required this.endDate,
    this.additionalInfo,
  });

  int get daysLeft {
    final now = DateTime.now();
    final difference = endDate.difference(now).inDays;
    return difference;
  }

  int get totalDays {
    return endDate.difference(startDate).inDays;
  }

  double get progress {
    final now = DateTime.now();
    final totalDuration = endDate.difference(startDate).inMilliseconds;
    final elapsedDuration = now.difference(startDate).inMilliseconds;

    if (totalDuration <= 0) return 0.0;
    if (elapsedDuration <= 0) return 0.0;
    if (elapsedDuration >= totalDuration) return 1.0;

    return elapsedDuration / totalDuration;
  }

  bool get isOverdue => daysLeft < 0;
  bool get expiresSoon => daysLeft <= 2 && daysLeft >= 0;
  bool get isActive => daysLeft > 2;

  String get formattedPeriod {
    final start = '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
    final end = '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';
    return '$start\nto $end';
  }

  String get statusInfo {
    if (isOverdue) {
      return '${daysLeft.abs()} days overdue';
    } else if (expiresSoon) {
      return '$daysLeft days left';
    } else if (isActive) {
      return '$daysLeft days left';
    }
    return '';
  }
}

class RentalData {
  final String id;
  final Customer customer;
  final String equipment;
  final RentalPeriod period;
  final double dailyRate;
  final double total;
  final StatusType status;
  final double? lateFee;
  final double? deposit;
  final String? notes;

  const RentalData({
    required this.id,
    required this.customer,
    required this.equipment,
    required this.period,
    required this.dailyRate,
    required this.total,
    required this.status,
    this.lateFee,
    this.deposit,
    this.notes,
  });

  String get formattedDailyRate => '\$${dailyRate.toStringAsFixed(0)}';

  String get formattedTotal {
    String totalStr = '\$${total.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    )}';

    if (lateFee != null && lateFee! > 0) {
      totalStr += '\n+\$${lateFee!.toStringAsFixed(0)} late fee';
    }

    return totalStr;
  }

  String get formattedDeposit => deposit != null ? '\$${deposit!.toStringAsFixed(0)}' : '';
}

