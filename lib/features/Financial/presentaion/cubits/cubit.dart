import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repo/financial_repo.dart';
import 'state.dart';

class EarningsReportCubit extends Cubit<EarningsReportState> {
  final EarningsReportRepo earningsReportRepo;
  EarningsReportCubit(this.earningsReportRepo) : super(EarningsReportInitial());

  Future<void> fetchEarningsReport({DateTime? startDate, DateTime? endDate}) async {
    emit(EarningsReportLoading());

    final now = DateTime.now();
    final dateToFetchStart = startDate ?? DateTime(now.year, 1, 1);
    final dateToFetchEnd = endDate ?? now;

    final result = await earningsReportRepo.getEarningsReport(
      startDate: dateToFetchStart,
      endDate: dateToFetchEnd,
    );

    result.fold(
          (failure) => emit(EarningsReportFailure(failure.errMessage)),
          (report) => emit(EarningsReportSuccess(report)),
    );
  }
}
