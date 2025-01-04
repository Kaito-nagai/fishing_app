import 'package:flutter/material.dart';
import 'package:fishing_app/pages/home_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome(); // 2秒後にホーム画面に遷移
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return; // Stateがまだ有効か確認
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sailing, size: 100, color: const Color.fromARGB(255, 224, 68, 68)),
            const SizedBox(height: 16),
            const Text(
              'Fishing App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
