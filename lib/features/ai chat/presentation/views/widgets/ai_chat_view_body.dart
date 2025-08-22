import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/message_entity.dart';
import '../../cubits/get ai messages cubit/get_ai_messages_cubit.dart';
import '../../cubits/send ai message/send_ai_message_cubit.dart';
import 'ai_composer.dart';
import 'ai_view_header.dart';
import 'message_view_port.dart';

class AiChatViewBody extends StatefulWidget {
  const AiChatViewBody({super.key});

  @override
  State<AiChatViewBody> createState() => _AiChatViewBodyState();
}

class _AiChatViewBodyState extends State<AiChatViewBody> {
  final ScrollController _scroll = ScrollController();
  final List<MessageEntity> _messages = [];
  bool _typing = false; // مؤشر "الذكاء عم يكتب"

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetAiMessagesCubit>().getMessages();
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  // مع reverse:true، الصفر يعني أسفل اللستة (آخر الرسائل)
  void _scrollToBottom({bool animated = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      if (animated) {
        _scroll.animateTo(
          0.0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      } else {
        _scroll.jumpTo(0.0);
      }
    });
  }

  void _onSendPressed(String text) {
    // 1) ضيف رسالة المستخدم فوراً
    _messages.add(MessageEntity(id: '', message: text, isUser: true));
    setState(() {});
    _scrollToBottom();

    // 2) فعّل مؤشر الكتابة وابعث الطلب عبر الكيوبِت
    setState(() => _typing = true);
    context.read<SendAiMessageCubit>().sendMessage(content: text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: MultiBlocListener(
        listeners: [
          // رسائل البداية من السيرفر
          BlocListener<GetAiMessagesCubit, GetAiMessagesState>(
            listener: (context, state) {
              if (state is GetAiMessagesSuccess) {
                _messages
                  ..clear()
                  ..addAll(state.messages);
                setState(() {});
                _scrollToBottom(animated: false);
              }
            },
          ),
          // إرسال الرسالة واستقبال الرد
          BlocListener<SendAiMessageCubit, SendAiMessageState>(
            listener: (context, state) {
              if (state is SendAiMessageLoading) {
                setState(() => _typing = true);
              } else if (state is SendAiMessageSuccess) {
                _messages.add(state.messageEntity); // ردّ الـ AI (isUser=false)
                setState(() => _typing = false);
                _scrollToBottom();
              } else if (state is SendAiMessageError) {
                setState(() => _typing = false);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errMessage)));
              }
            },
          ),
        ],
        child: Column(
          children: [
            AiHeader(
              heroTag: "ai-hero", // لربط الـ Hero إذا موجود
              title: "AI Assistant",
              subtitle: "كيف فيني ساعدك اليوم؟",
              onBack: () => Navigator.of(context).maybePop(),
            ),
            Divider(
              height: 1,
              color: theme.dividerTheme.color,
              thickness: theme.dividerTheme.thickness ?? .1,
            ),

            // اللائحة: reverse:true تبقيك أسفل الرسائل
            Expanded(
              child: MessagesViewport(
                controller: _scroll,
                messages: _messages,
                typing: _typing,
              ),
            ),

            // المُرسِل
            BlocBuilder<SendAiMessageCubit, SendAiMessageState>(
              builder: (context, state) {
                final loading = state is SendAiMessageLoading;
                return AiComposer(loading: loading, onSend: _onSendPressed);
              },
            ),
          ],
        ),
      ),
    );
  }
}
