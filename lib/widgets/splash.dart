import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/widgets/login.dart';
import 'package:taxi_app/widgets/onboarding.dart';
import 'package:taxi_app/pages/google_map.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool firstTimeUser = true;

  @override
  // ignore: must_call_super
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const OnboardingPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarGlow(
              glowColor: Colors.amber,
              endRadius: 90.0,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: const Duration(milliseconds: 100),
              child: Material(
                // Replace this child with your own
                elevation: 8.0,
                shape: const CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  radius: 60.0,
                  child: Image.asset(
                    'assets/taxi.png',
                    height: 100,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 250.0,
              child: TextLiquidFill(
                text: 'SenTaxi',
                waveColor: Colors.amber,
                boxBackgroundColor: Colors.white,
                textStyle: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic),
                boxHeight: 80.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
