import 'package:ai_assistant/models/message.dart';
import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.all(14),
      constraints: BoxConstraints(
        maxWidth: mediaQuery.width * 0.75,
      ),
      decoration: BoxDecoration(
        color: message.backgroundColor(context),
        borderRadius: message.borderRadius,
      ),
      child: Text(
        message.text!,
        style: TextStyle(
          color: message.textColor(context),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
