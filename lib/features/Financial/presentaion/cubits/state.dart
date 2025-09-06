import '../../domain/entity/financial_entity.dart';

abstract class EarningsReportState {}
class EarningsReportInitial extends EarningsReportState {}
class EarningsReportLoading extends EarningsReportState {}

class EarningsReportSuccess extends EarningsReportState {
  // ✅ حالة النجاح تحتوي على تقرير واحد فقط
  final EarningsReportEntity report;
  EarningsReportSuccess(this.report);
}

class EarningsReportFailure extends EarningsReportState {
  final String errMessage;
  EarningsReportFailure(this.errMessage);
}
