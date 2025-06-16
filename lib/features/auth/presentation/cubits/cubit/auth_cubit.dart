import 'package:bloc/bloc.dart';
import 'package:med_tech_admin/features/auth/domain/entities/user_entity.dart';
import 'package:med_tech_admin/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;
  void signin({required String email, required String password}) async {
    var result = await authRepo.signinUsingEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (err) => emit(AuthFailure(errMessage: err.errMessage)),
      (user) => emit(AuthSuccess(userEntity: user)),
    );
  }
}
