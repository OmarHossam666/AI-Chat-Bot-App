import 'package:ai_assistant/models/message.dart';
import 'package:flutter/material.dart';

class MediaMessage extends StatelessWidget {
  const MediaMessage({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: mediaQuery.width * 0.75),
      child: Column(
        children: [
          // Container
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: message.backgroundColor(context),
              borderRadius: message.borderRadius,
            ),
            child: Column(
              children: [
                // Image
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      message.mediaUrl!,
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Caption
                Text(
                  message.text!,
                  style: TextStyle(
                    color: message.textColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Icons For Actions
          Row(
            children: [
              IconButton.outlined(
                onPressed: () {},
                icon: const Icon(Icons.thumb_up),
              ),
              const SizedBox(width: 10),
              IconButton.outlined(
                onPressed: () {},
                icon: const Icon(Icons.thumb_down),
              ),
              const Spacer(),
              IconButton.outlined(
                onPressed: () {},
                icon: const Icon(Icons.copy),
              ),
              const SizedBox(width: 10),
              IconButton.outlined(
                onPressed: () {},
                icon: const Icon(Icons.share),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
