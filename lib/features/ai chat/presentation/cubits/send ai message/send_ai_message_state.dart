part of 'send_ai_message_cubit.dart';

@immutable
sealed class SendAiMessageState {}

final class SendAiMessageInitial extends SendAiMessageState {}

final class SendAiMessageLoading extends SendAiMessageState {}

final class SendAiMessageSuccess extends SendAiMessageState {
  final MessageEntity messageEntity;

  SendAiMessageSuccess({required this.messageEntity});
}

final class SendAiMessageError extends SendAiMessageState {
  final String errMessage;

  SendAiMessageError({required this.errMessage});
}
