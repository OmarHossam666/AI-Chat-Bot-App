import 'package:ai_assistant/data/messages.dart';
import 'package:ai_assistant/models/message.dart';
import 'package:ai_assistant/widgets/media_message.dart';
import 'package:ai_assistant/widgets/text_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatWithAiPage extends StatelessWidget {
  const ChatWithAiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat with AI Bot"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Scrollable Widget That Displays The Messages.
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return Align(
                      alignment: message.sender == MessageSender.human
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: message.type == MessageType.text
                          ? TextMessage(message: message)
                          : MediaMessage(message: message),
                    );
                  },
                  itemCount: messages.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                ),
              ),
              // Text Form Field
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.attachment),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.mic),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Type your message here...",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
