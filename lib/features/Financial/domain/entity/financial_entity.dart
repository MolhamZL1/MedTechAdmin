class EarningsReportEntity {
  final ReportParametersEntity reportParameters;
  final ReportSummaryEntity summary;
  final RevenueBreakdownEntity revenueBreakdown;
  final TransactionCountsEntity transactionCounts;

  const EarningsReportEntity({
    required this.reportParameters,
    required this.summary,
    required this.revenueBreakdown,
    required this.transactionCounts,
  });
}

class ReportParametersEntity {
  final DateTime startDate;
  final DateTime endDate;
  final String type;

  const ReportParametersEntity({
    required this.startDate,
    required this.endDate,
    required this.type,
  });
}

class ReportSummaryEntity {
  final double grossRevenue;
  final double costOfGoodsSold;
  final double grossProfit;

  const ReportSummaryEntity({
    required this.grossRevenue,
    required this.costOfGoodsSold,
    required this.grossProfit,
  });
}

class RevenueBreakdownEntity {
  final double productSales;
  final double productRentals;
  final double maintenanceServices;

  const RevenueBreakdownEntity({
    required this.productSales,
    required this.productRentals,
    required this.maintenanceServices,
  });
}

class TransactionCountsEntity {
  final int paidOrders;
  final int completedMaintenance;

  const TransactionCountsEntity({
    required this.paidOrders,
    required this.completedMaintenance,
  });
}
