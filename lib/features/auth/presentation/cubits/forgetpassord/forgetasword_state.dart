part of 'forgetasword_cubit.dart';

@immutable
sealed class ForgetaswordState {}

final class ForgetaswordInitial extends ForgetaswordState {}

final class ForgetaswordLoading extends ForgetaswordState {}

final class ForgetaswordSuccess extends ForgetaswordState {}

final class ForgetaswordError extends ForgetaswordState {
  final String message;
  ForgetaswordError({required this.message});
}
