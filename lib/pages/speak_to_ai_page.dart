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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeVoiceFeatures();
  }

  /// Initializes Speech-to-Text and Text-to-Speech features.
  Future<void> _initializeVoiceFeatures() async {
    _speechToText = SpeechToText();
    _flutterTts = FlutterTts();

    await Future.wait([_initSpeech(), _configureTts()]);
  }

  /// Initializes the SpeechToText engine.
  Future<void> _initSpeech() async {
    if (!await _speechToText.initialize()) {
      debugPrint("SpeechToText initialization failed.");
    }
  }

  /// Configures the FlutterTTS instance.
  Future<void> _configureTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setVolume(1.0);
    await _flutterTts
        .setVoice({"name": "en-us-x-sfg#female_1", "locale": "en-US"});
  }

  /// Speaks out the response text.
  Future<void> _speakResponse(String text) async {
    if (text.isNotEmpty) {
      await _flutterTts.stop(); // Stops any ongoing speech.
      await _flutterTts.speak(text);
    }
  }

  /// Starts listening to the user's voice.
  Future<void> _startListening() async {
    if (await _speechToText.hasPermission) {
      await _speechToText.listen(onResult: _onSpeechResult);
    } else {
      await _initSpeech();
    }
  }

  /// Stops listening to the user's voice.
  Future<void> _stopListening() async {
    if (_speechToText.isListening) {
      await _speechToText.stop();
    }
  }

  /// Handles speech recognition results.
  void _onSpeechResult(SpeechRecognitionResult result) {
    final recognizedWords = result.recognizedWords;

    if (recognizedWords.isNotEmpty && result.finalResult) {
      setState(() {
        _recognizedText = recognizedWords;
        _isLoading = true;
      });
      _sendToGemini(recognizedWords);
    }
  }

  /// Sends the recognized voice command to the Gemini API.
  Future<void> _sendToGemini(String voiceCommand) async {
    try {
      final response =
          await Gemini.instance.prompt(parts: [Part.text(voiceCommand)]);
      final output = response?.output?.replaceAll('*', '') ??
          "Failed to generate a response.";

      setState(() {
        _responseText = output;
      });
      await _speakResponse(output);
    } catch (error) {
      setState(() {
        _responseText = "Error: ${error.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Resets the recognized and response text.
  void _resetText() {
    setState(() {
      _recognizedText = "";
      _responseText = "";
    });
    _flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size mediaQuery = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Speak to Moon"),
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
          _isLoading
              ?
              // Loading Animation
              Center(
                  child: Lottie.asset(
                    'assets/lottie/loading.json',
                    width: mediaQuery.width * 0.25,
                    height: mediaQuery.height * 0.25,
                  ),
                )
              :
              // The Text That Generated From The User
              Text(
                  _responseText.isEmpty
                      ? _recognizedText.isEmpty
                          ? "Click on the mic button to generate a voice command."
                          : _recognizedText
                      : _responseText,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
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
                if (_speechToText.isNotListening) {
                  await _startListening();
                } else if (_speechToText.isListening) {
                  await _stopListening();
                } else {
                  await _initSpeech();
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
              onPressed: _resetText,
              icon: Icon(
                Icons.delete,
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
