import 'package:ai_assistant/models/message.dart';
import 'package:ai_assistant/widgets/media_message.dart';
import 'package:ai_assistant/widgets/text_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:lottie/lottie.dart';

class ChatWithAiPage extends StatefulWidget {
  const ChatWithAiPage({super.key});

  @override
  State<ChatWithAiPage> createState() => _ChatWithAiPageState();
}

class _ChatWithAiPageState extends State<ChatWithAiPage> {
  final _textController = TextEditingController();
  final List<Message> _chatMessages = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  /// Sends a user message and fetches the AI's response.
  Future<void> _sendMessage() async {
    final userInput = _textController.text.trim();
    if (userInput.isEmpty) return;

    _addMessage(
      Message(
        type: MessageType.text,
        sender: MessageSender.human,
        text: userInput,
      ),
    );

    _textController.clear();
    setState(() => _isLoading = true);

    try {
      final response =
          await Gemini.instance.prompt(parts: [Part.text(userInput)]);
      final output = response?.output?.replaceAll('*', '') ?? '';

      final Message aiMessage = _isImageResponse(output)
          ? Message(
              type: MessageType.media,
              sender: MessageSender.bot,
              text: "Here's an image result.",
              mediaUrl: output,
            )
          : Message(
              type: MessageType.text,
              sender: MessageSender.bot,
              text: output,
            );

      _addMessage(aiMessage);
    } catch (error) {
      _addMessage(
        const Message(
          type: MessageType.text,
          sender: MessageSender.bot,
          text: "Sorry, something went wrong. Please try again.",
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Adds a message to the chat list and updates the UI.
  void _addMessage(Message message) {
    setState(() {
      _chatMessages.add(message);
    });
  }

  /// Checks if the response contains an image URL.
  bool _isImageResponse(String output) {
    return output.contains('http') &&
        (output.contains('.jpg') ||
            output.contains('.png') ||
            output.contains('.jpeg'));
  }

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat with Moon"),
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
                    final message = _chatMessages[index];
                    return Align(
                      alignment: message.sender == MessageSender.human
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: message.type == MessageType.text
                          ? TextMessage(message: message)
                          : MediaMessage(message: message),
                    );
                  },
                  itemCount: _chatMessages.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                ),
              ),
              // Loading Animation
              if (_isLoading)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Lottie.asset(
                    'assets/lottie/loading.json',
                    width: mediaQuery.width * 0.25,
                  ),
                ),
              // Text Form Field
              TextFormField(
                controller: _textController,
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.attachment),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send),
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
