import 'package:med_tech_admin/features/Financial/data/transaction.dart';



class sampleData {
  // بيانات الإيرادات والمصروفات الشهرية
  static List<Map<String, dynamic>> monthlyData = [
    {'month': 'Jan', 'sales': 120, 'rentals': 80, 'maintenance': 40, 'expenses': 90},
    {'month': 'Feb', 'sales': 150, 'rentals': 70, 'maintenance': 45, 'expenses': 110},
    {'month': 'Mar', 'sales': 140, 'rentals': 90, 'maintenance': 35, 'expenses': 120},
    {'month': 'Apr', 'sales': 180, 'rentals': 85, 'maintenance': 30, 'expenses': 130},
    {'month': 'May', 'sales': 160, 'rentals': 95, 'maintenance': 38, 'expenses': 100},
    {'month': 'Jun', 'sales': 200, 'rentals': 110, 'maintenance': 42, 'expenses': 140},
  ];

  // بيانات توزيع الإيرادات
  static Map<String, dynamic> revenueBreakdown = {
    'Sales Revenue': {'amount': 245670, 'percentage': 57.7, 'color': 0xFF2196F3},
    'Rental Revenue': {'amount': 125000, 'percentage': 29.4, 'color': 0xFF4CAF50},
    'Maintenance Revenue': {'amount': 55000, 'percentage': 12.9, 'color': 0xFFFF9800},
  };

  // بيانات المعاملات الحديثة
  static List<Transaction> recentTransactions = [
    Transaction(
      id: 'TXN-001',
      type: 'Sale',
      customer: 'City General Hospital',
      amount: 45000,
      date: '2024-01-15',
      status: 'Completed',
    ),
    Transaction(
      id: 'TXN-002',
      type: 'Rental',
      customer: 'Medical Center Plus',
      amount: 12000,
      date: '2024-01-14',
      status: 'Completed',
    ),
    Transaction(
      id: 'TXN-003',
      type: 'Maintenance',
      customer: 'Emergency Care Unit',
      amount: 850,
      date: '2024-01-13',
      status: 'Completed',
    ),
    Transaction(
      id: 'TXN-004',
      type: 'Sale',
      customer: 'Private Clinic',
      amount: 8000,
      date: '2024-01-12',
      status: 'Pending',
    ),
  ];
}

