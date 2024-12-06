import 'package:ai_assistant/pages/chat_with_ai_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpeakToAiPage extends StatefulWidget {
  const SpeakToAiPage({super.key});

  @override
  State<SpeakToAiPage> createState() => _SpeakToAiPageState();
}

class _SpeakToAiPageState extends State<SpeakToAiPage> {
  late SpeechToText _speechToText;
  late FlutterTts _flutterTts;
  String _recognizedText = "";
  String _responseText = "";

  @override
  void initState() {
    super.initState();
    _speechToText = SpeechToText();
    _flutterTts = FlutterTts();
    _initSpeech();
    _configureTts();
  }

  Future<void> _initSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  Future<void> _configureTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setVolume(1.0);
    await _flutterTts
        .setVoice({"name": "en-us-x-sfg#female_1", "locale": "en-US"});
  }

  Future<void> _speakResponse(String text) async {
    if (text.isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

  Future<void> _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _recognizedText = result.recognizedWords;
    });

    if (_recognizedText.isNotEmpty) {
      _sendToGemini(_recognizedText);
    }
  }

  Future<void> _sendToGemini(String voiceCommand) async {
    try {
      final response =
          await Gemini.instance.prompt(parts: [Part.text(voiceCommand)]);

      setState(() {
        _responseText = response?.output?.replaceAll('*', '') ??
            "An error occurred while generating a response.";
      });

      await _speakResponse(_responseText);
    } catch (error) {
      setState(() {
        _responseText = "Error: ${error.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Speaking to AI Bot"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Image Of A Robot
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Lottie.asset("assets/lottie/speaking_to_ai_bot.json"),
          ),
          // The Text That Generated From The User
          Text.rich(
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            TextSpan(
              text: _responseText.isEmpty
                  ? _recognizedText.isEmpty
                      ? "Click on the mic button to generate a voice command."
                      : _recognizedText
                  : _responseText,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton.filledTonal(
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChatWithAiPage()),
                );
              },
              icon: Icon(
                Icons.keyboard,
                size: 30,
                color: theme.colorScheme.onSecondary,
              ),
            ),
            IconButton.filledTonal(
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
              ),
              onPressed: () async {
                if (await _speechToText.hasPermission &&
                    _speechToText.isNotListening) {
                  await _startListening();
                } else if (_speechToText.isListening) {
                  await _stopListening();
                } else {
                  _initSpeech();
                }
              },
              icon: Icon(
                _speechToText.isNotListening
                    ? CupertinoIcons.mic
                    : CupertinoIcons.stop,
                size: 60,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            IconButton.filledTonal(
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary,
              ),
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz,
                size: 30,
                color: theme.colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
