import 'package:ai_assistant/pages/speak_to_ai_page.dart';
import 'package:flutter/material.dart';

class IdealCard extends StatelessWidget {
  const IdealCard({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: SizedBox(
        height: 165,
        child: Card.filled(
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              // Navigate To AI Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SpeakToAiPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: theme.colorScheme.onPrimary,
                    child: Icon(icon),
                  ),
                  Text(
                    text,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
