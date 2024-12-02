import 'package:flutter/material.dart';

class Message {
  const Message({
    required this.type,
    required this.sender,
    this.mediaUrl,
    this.text,
  });

  final MessageType type;
  final String? mediaUrl;
  final MessageSender sender;
  final String? text;
}

enum MessageType { text, media }

enum MessageSender { bot, human }

extension MessageExtension on Message {
  Color textColor(BuildContext context) {
    switch (sender) {
      case MessageSender.human:
        return Theme.of(context).colorScheme.onPrimary;
      case MessageSender.bot:
        return Theme.of(context).colorScheme.onSecondary;
    }
  }

  Color backgroundColor(BuildContext context) {
    switch (sender) {
      case MessageSender.human:
        return Theme.of(context).colorScheme.primary;
      case MessageSender.bot:
        return Theme.of(context).colorScheme.secondary;
    }
  }

  BorderRadius get borderRadius {
    switch (sender) {
      case MessageSender.human:
        return const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(4),
        );
      case MessageSender.bot:
        return const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(18),
        );
    }
  }
}
