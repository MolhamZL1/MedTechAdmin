import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/message_entity.dart';

abstract class AiChatRepo {
  Future<Either<Failure, MessageEntity>> sendMessage(String message);
  Future<Either<Failure, List<MessageEntity>>> getMessages();
}
