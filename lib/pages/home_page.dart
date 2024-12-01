import 'package:ai_assistant/widgets/ideal_card.dart';
import 'package:ai_assistant/widgets/premium_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const int numberOfHistories = 5;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Premium Card
            const PremiumCard(),
            const SizedBox(height: 10),
            // Row With 2 Cards
            const Row(
              children: [
                IdealCard(
                  text: 'Generate ideas & write articles',
                  icon: Icons.border_color,
                ),
                SizedBox(width: 10),
                IdealCard(
                  text: 'Generate pictures & arts',
                  icon: Icons.image,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Heading Text
            Text(
              "History",
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // List Of History Views
            Wrap(
              runSpacing: 15,
              children: List.generate(
                numberOfHistories,
                (index) {
                  return ListTile(
                    onTap: () {},
                    titleTextStyle: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    title: const Text(
                      "Generating an image cat that playing video games.",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: const Icon(Icons.chat_outlined),
                    trailing: const Icon(Icons.arrow_forward_rounded),
                  );
                },
              ),
            ),
            // Bottom Navigation Bar
          ],
        ),
      ),
    );
  }
}
