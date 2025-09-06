import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/widgets/show_err_dialog.dart';
import '../../../../core/widgets/showsuccessDialog.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../orders/domain/entities/order_entity.dart';
import '../../domain/entities/entity.dart';
import '../../domain/entities/user-entity.dart';
import '../../domain/repos/user_repo.dart';
import '../views/widgets/user_order.dart';

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
          (_)  {
        fetchUsers();
        return "User created successfully";
      },
    );
  }

  // Updated method to show dialog directly
  Future<void> fetchUserOrders(BuildContext context, String userId, String username) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    final result = await userRepo.getUserOrders(userId);

    // Close loading indicator
    Navigator.of(context).pop();

    result.fold(
          (failure) {
        // Check if the failure message indicates no orders found
        if (failure.errMessage == "No orders found for this user") {
          UserOrdersDialog.showOrdersDialog(
            context: context,
            orders: [], // Pass an empty list for no orders
            username: username,
          );
        } else {
          // Show generic error dialog for other failures
          showsuccessDialog(
            context: context,
            title: "Sorry",
            description:"No orders found for this user for $username",
          );
        }
      },
          (orders) {
        // Show the attractive orders dialog
        UserOrdersDialog.showOrdersDialog(
          context: context,
          orders: orders,
          username: username,
        );
      },
    );
  }

  // Alternative method if you want to keep the state-based approach
  Future<void> fetchUserOrdersWithState(BuildContext context, String userId) async {
    emit(UserLoading());
    final result = await userRepo.getUserOrders(userId);
    result.fold(
          (failure) => emit(UserFailure(errMessage: failure.errMessage)),
          (orders) {
        emit(UserOrdersSuccess(ordersEntity: orders));
      },
    );
  }
}

// Import this function from your existing error dialog file



