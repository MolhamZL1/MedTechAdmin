import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repos/auth_repo.dart';

part 'forgetasword_state.dart';

class ForgetaswordCubit extends Cubit<ForgetaswordState> {
  ForgetaswordCubit(this.authRepo) : super(ForgetaswordInitial());
  final AuthRepo authRepo;

  void forgetPassword({required String email}) async {
    emit(ForgetaswordLoading());
    var result = await authRepo.forgetPassword(email: email);
    result.fold(
      (failure) => emit(ForgetaswordError(message: failure.errMessage)),
      (userEntity) => emit(ForgetaswordSuccess()),
    );
  }
}
