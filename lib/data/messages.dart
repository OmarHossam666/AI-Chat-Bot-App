import 'package:ai_assistant/models/message.dart';

List<Message> messages = [
  const Message(
    type: MessageType.text,
    sender: MessageSender.human,
    text:
        "Describe and show me the perfect vacation spot on an island in the ocean",
  ),
  const Message(
    type: MessageType.text,
    sender: MessageSender.bot,
    text:
        "Describe and show me the perfect vacation spot on an island in the ocean",
  ),
  const Message(
    type: MessageType.media,
    sender: MessageSender.bot,
    text:
        "Imagine yourself on an idyllic island in the middle of the vast ocean, where  turquoise waters and powdery white  sand surround you. This perfect  vacation spot is a tropical paradise  that offers a blend of tranquility and  adventure.",
    mediaUrl:
        "https://images.unsplash.com/photo-1483683804023-6ccdb62f86ef?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ),
];
