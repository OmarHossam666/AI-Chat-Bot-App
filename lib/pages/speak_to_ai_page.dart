import 'package:ai_assistant/pages/chat_with_ai_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SpeakToAiPage extends StatelessWidget {
  const SpeakToAiPage({super.key});

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
              text: "Describe and show me the perfect vacation spot",
              children: [
                TextSpan(
                  text: " on an island in the ocean",
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
              ],
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
                backgroundColor: theme.colorScheme.onSecondary,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChatWithAiPage()),
                );
              },
              icon: const Icon(
                Icons.keyboard,
                size: 30,
              ),
            ),
            IconButton.filledTonal(
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.onPrimary,
              ),
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.mic,
                size: 60,
              ),
            ),
            IconButton.filledTonal(
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.onSecondary,
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
