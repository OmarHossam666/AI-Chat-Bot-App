import 'package:ai_assistant/data/messages.dart';
import 'package:ai_assistant/models/message.dart';
import 'package:ai_assistant/widgets/media_message.dart';
import 'package:ai_assistant/widgets/text_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatWithAiPage extends StatefulWidget {
  const ChatWithAiPage({super.key});

  @override
  State<ChatWithAiPage> createState() => _ChatWithAiPageState();
}

class _ChatWithAiPageState extends State<ChatWithAiPage> {
  late SpeechToText _speechToText;
  String _recognizedText = "";

  @override
  void initState() {
    super.initState();
    _speechToText = SpeechToText();
    _initSpeech();
  }

  void _initSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      final message = Message(
          type: MessageType.text,
          sender: MessageSender.human,
          text: _recognizedText);
      messages.add(message);
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _recognizedText = result.recognizedWords;
    });
  }

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
                    onPressed: () {
                      if (_speechToText.isNotListening) {
                        _startListening();
                      } else {
                        _stopListening();
                      }
                    },
                    icon: _speechToText.isNotListening
                        ? const Icon(CupertinoIcons.mic)
                        : const Icon(CupertinoIcons.stop),
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
