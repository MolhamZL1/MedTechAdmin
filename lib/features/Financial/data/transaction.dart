class Transaction {
  final String id;
  final String type;
  final String customer;
  final double amount;
  final String date;
  final String status;

  Transaction({
    required this.id,
    required this.type,
    required this.customer,
    required this.amount,
    required this.date,
    required this.status,
  });
}

