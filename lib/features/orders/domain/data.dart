import '../../rentaling/utils/constants.dart';

class Customerr {
  final String name;
  final String organization;

  const Customerr({
    required this.name,
    required this.organization,
  });

  @override
  String toString() => '$name\n$organization';
}

class OrderPeriod {
  final DateTime startDate;
  final DateTime endDate;
  final String? additionalInfo;

  const OrderPeriod({
    required this.startDate,
    required this.endDate,
    this.additionalInfo,
  });

  int get daysLeft {
    final now = DateTime.now();
    final difference = endDate.difference(now).inDays;
    return difference;
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

class OrderData {
  final String id;
  final Customerr customer;
  final String equipment;
  final OrderPeriod period;
  final double dailyRate;
  final double total;
  final StatusType status;
  final double? lateFee;

  const OrderData({
    required this.id,
    required this.customer,
    required this.equipment,
    required this.period,
    required this.dailyRate,
    required this.total,
    required this.status,
    this.lateFee,
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
}

