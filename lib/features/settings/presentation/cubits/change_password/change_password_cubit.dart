import 'package:bloc/bloc.dart';
import 'package:med_tech_admin/features/settings/domain/rpeos/settings_repo.dart';
import 'package:meta/meta.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.settingsRepo) : super(ChangePasswordInitial());
  final SettingsRepo settingsRepo;
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoading());
    final result = await settingsRepo.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    result.fold(
      (l) => emit(ChangePasswordError(l.errMessage)),
      (r) => emit(ChangePasswordSuccess()),
    );
  }
}
