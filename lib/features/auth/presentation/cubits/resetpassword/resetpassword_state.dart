part of 'resetpassword_cubit.dart';

@immutable
sealed class ResetpasswordState {}

final class ResetpasswordInitial extends ResetpasswordState {}

final class ResetPasswordSuccess extends ResetpasswordState {}

final class ResetPasswordError extends ResetpasswordState {
  final String message;
  ResetPasswordError(this.message);
}

final class ResetPasswordLoading extends ResetpasswordState {}
