import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../domain/repos/ai_chat_repo.dart';
import '../cubits/get ai messages cubit/get_ai_messages_cubit.dart';
import '../cubits/send ai message/send_ai_message_cubit.dart';
import 'widgets/ai_chat_view_body.dart';

class AiChatView extends StatelessWidget {
  const AiChatView({super.key});
  static const routeName = '/ai-chat';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SendAiMessageCubit(getIt.get<AiChatRepo>()),
        ),
        BlocProvider(
          create: (_) => GetAiMessagesCubit(getIt.get<AiChatRepo>()),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: AiChatViewBody(),
      ),
    );
  }
}
