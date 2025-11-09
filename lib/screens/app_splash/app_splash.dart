import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rick_and_morty/resources/images_src.dart';
import 'package:rick_and_morty/screens/main_screen/main_screen.dart';

class AppSplash extends StatefulWidget {
  const AppSplash({super.key});

  @override
  State<AppSplash> createState() => _AppSplashState();
}

class _AppSplashState extends State<AppSplash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImagesSrc.splash, width: double.infinity, fit: BoxFit.cover);
  }
}
