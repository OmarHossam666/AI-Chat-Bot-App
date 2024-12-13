import 'package:ai_assistant/models/message.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({super.key, required this.message});

  final Message message;

  Future<void> _shareResponse(String response) async {
    if (response.isNotEmpty) {
      await Share.share(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
        ),
        if (message.sender == MessageSender.bot)
          // Improved Icons Layout
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton.outlined(
                      onPressed: () {},
                      icon: const Icon(Icons.thumb_up),
                    ),
                    IconButton.outlined(
                      onPressed: () {},
                      icon: const Icon(Icons.thumb_down),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
                IconButton.outlined(
                  onPressed: () async {
                    _shareResponse(message.text!);
                  },
                  icon: const Icon(Icons.share),
                ),
                const Spacer(),
              ],
            ),
          ),
      ],
    );
  }
}
