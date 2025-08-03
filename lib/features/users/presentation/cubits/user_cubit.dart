import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/functions/getLocalUser.dart';
import '../../../../core/services/get_it_service.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/entity.dart';
import '../../domain/entities/user-entity.dart';
import '../../domain/repos/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo userRepo;
  UserCubit(this.userRepo) : super(UserInitial());

  Future<void> fetchUsers() async {
    emit(UserLoading());
    final result = await userRepo.getUsers();
    result.fold(
      (failure) => emit(UserFailure(errMessage: failure.errMessage)),
      (users) => emit(UserSuccess(usersEntity: users)),
    );
  }

  Future<void> deleteUser(String id) async {
    emit(UserLoading());
    final result = await userRepo.deleteUser(id);
    result.fold(
      (failure) => emit(UserFailure(errMessage: failure.errMessage)),
      (_) => fetchUsers(),
    );
  }

  Future<void> banUser(String id) async {
    emit(UserLoading());
    final result = await userRepo.banUser(id);
    result.fold(
      (failure) => emit(UserFailure(errMessage: failure.errMessage)),
      (_) => fetchUsers(),
    );
  }

  Future<void> unbanUser(String id) async {
    emit(UserLoading());
    final result = await userRepo.unbanUser(id);
    result.fold(
      (failure) => emit(UserFailure(errMessage: failure.errMessage)),
      (_) => fetchUsers(),
    );
  }

  Future<String?> createUser(CreateUserEntity users) async {
    emit(UserLoading());
    final result = await userRepo.createUserByAdmin(users);
    return result.fold(
      (failure) {
        emit(UserFailure(errMessage: failure.errMessage));
        return failure.errMessage;
      },
      (_) {
        fetchUsers();
        return "User created successfully";
      },
    );
  }
}
