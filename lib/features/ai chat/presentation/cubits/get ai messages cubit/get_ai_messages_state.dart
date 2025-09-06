part of 'get_ai_messages_cubit.dart';

@immutable
sealed class GetAiMessagesState {}

final class GetAiMessagesInitial extends GetAiMessagesState {}

final class GetAiMessagesLoading extends GetAiMessagesState {}

final class GetAiMessagesSuccess extends GetAiMessagesState {
  final List<MessageEntity> messages;
  GetAiMessagesSuccess({required this.messages});
}

final class GetAiMessagesFailure extends GetAiMessagesState {
  final String failure;
  GetAiMessagesFailure({required this.failure});
}
