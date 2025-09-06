
// Helper function to safely parse numbers
import '../../domain/entity/financial_entity.dart';

double _parseDouble(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }
  return 0.0;
}

class EarningsReportModel extends EarningsReportEntity {
  const EarningsReportModel({
    required ReportParametersModel reportParameters,
    required ReportSummaryModel summary,
    required RevenueBreakdownModel revenueBreakdown,
    required TransactionCountsModel transactionCounts,
  }) : super(
    reportParameters: reportParameters,
    summary: summary,
    revenueBreakdown: revenueBreakdown,
    transactionCounts: transactionCounts,
  );

  factory EarningsReportModel.fromJson(Map<String, dynamic> json) {
    return EarningsReportModel(
      reportParameters: ReportParametersModel.fromJson(json['reportParameters']),
      summary: ReportSummaryModel.fromJson(json['summary']),
      revenueBreakdown: RevenueBreakdownModel.fromJson(json['revenueBreakdown']),
      transactionCounts: TransactionCountsModel.fromJson(json['transactionCounts']),
    );
  }

  EarningsReportEntity toEntity() => this;
}

// --- Sub-Models ---

class ReportParametersModel extends ReportParametersEntity {
  const ReportParametersModel({
    required DateTime startDate,
    required DateTime endDate,
    required String type,
  }) : super(startDate: startDate, endDate: endDate, type: type);

  factory ReportParametersModel.fromJson(Map<String, dynamic> json) {
    return ReportParametersModel(
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      type: json['type'],
    );
  }
}

class ReportSummaryModel extends ReportSummaryEntity {
  const ReportSummaryModel({
    required double grossRevenue,
    required double costOfGoodsSold,
    required double grossProfit,
  }) : super(
    grossRevenue: grossRevenue,
    costOfGoodsSold: costOfGoodsSold,
    grossProfit: grossProfit,
  );

  factory ReportSummaryModel.fromJson(Map<String, dynamic> json) {
    return ReportSummaryModel(
      grossRevenue: _parseDouble(json['grossRevenue']),
      costOfGoodsSold: _parseDouble(json['costOfGoodsSold']),
      grossProfit: _parseDouble(json['grossProfit']),
    );
  }
}

class RevenueBreakdownModel extends RevenueBreakdownEntity {
  const RevenueBreakdownModel({
    required double productSales,
    required double productRentals,
    required double maintenanceServices,
  }) : super(
    productSales: productSales,
    productRentals: productRentals,
    maintenanceServices: maintenanceServices,
  );

  factory RevenueBreakdownModel.fromJson(Map<String, dynamic> json) {
    return RevenueBreakdownModel(
      productSales: _parseDouble(json['productSales']),
      productRentals: _parseDouble(json['productRentals']),
      maintenanceServices: _parseDouble(json['maintenanceServices']),
    );
  }
}

class TransactionCountsModel extends TransactionCountsEntity {
  const TransactionCountsModel({
    required int paidOrders,
    required int completedMaintenance,
  }) : super(
    paidOrders: paidOrders,
    completedMaintenance: completedMaintenance,
  );

  factory TransactionCountsModel.fromJson(Map<String, dynamic> json) {
    return TransactionCountsModel(
      paidOrders: json['paidOrders'] ?? 0,
      completedMaintenance: json['completedMaintenance'] ?? 0,
    );
  }
}
