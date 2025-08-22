import 'package:flutter/material.dart';

import '../../../domain/entities/message_entity.dart';
import 'ai_message_bubble.dart';
import 'typing_bubble.dart';

class MessagesViewport extends StatelessWidget {
  const MessagesViewport({
    required this.controller,
    required this.messages,
    required this.typing,
  });

  final ScrollController controller;
  final List<MessageEntity> messages;
  final bool typing;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty && !typing) {
      return Center(
        child: Text(
          'ابدأ المحادثة الآن…',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    final total = messages.length + (typing ? 1 : 0);

    return ListView.builder(
      controller: controller,
      reverse: true, // 👈 سر الواتساب
      padding: const EdgeInsets.all(12),
      itemCount: total,
      itemBuilder: (_, i) {
        // مع reverse:true، i=0 هو أسفل القائمة
        if (typing && i == 0) {
          return const TypingBubble();
        }
        final offset = typing ? i - 1 : i;
        final msgIndex = messages.length - 1 - offset;
        final m = messages[msgIndex];
        return AiMessageBubble(text: m.message, isUser: m.isUser);
      },
    );
  }
}
