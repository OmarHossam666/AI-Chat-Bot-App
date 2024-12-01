import 'package:ai_assistant/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 4),
      () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Card(
              color: theme.colorScheme.onPrimary,
              child: Image.asset(
                "assets/images/logo.png",
                width: mediaQuery.width * 0.5,
              ),
            ),
            const Spacer(),
            Lottie.asset(
              "assets/lottie/splash_screen_loading.json",
              width: mediaQuery.width * 0.4,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
