import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PremiumCard extends StatelessWidget {
  const PremiumCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card.filled(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Premium Plan",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Harness the full power of AI with a Premium Plan",
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.bolt),
                    label: const Text("Upgrade Now"),
                  ),
                ],
              ),
            ),
            // Image Of Robot With Heart
            Lottie.asset(
              "assets/lottie/ai_heart.json",
              width: 120,
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}
