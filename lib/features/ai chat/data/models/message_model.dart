import '../../domain/entities/message_entity.dart';

class MessageModel {
  final String id;
  final String message;
  final bool isUser;

  MessageModel({required this.id, required this.message, required this.isUser});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      message: json['content'],
      isUser: json['isUser'],
    );
  }

  toEntity() => MessageEntity(id: id, message: message, isUser: isUser);
}
