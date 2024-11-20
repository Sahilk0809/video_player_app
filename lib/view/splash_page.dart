import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player_app/view/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      },
    );
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/img/ytlogo.png',
          height: 80,
        ),
      ),
    );
  }
}
