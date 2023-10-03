import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'world_states_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorldStatesScreen(),
            )));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedBuilder(
              animation: _controller,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.01,
                height: MediaQuery.sizeOf(context).height * 0.4,
                child: const Image(
                  image: AssetImage('images/virus.png'),
                ),
              ),
              builder: (context, child) => Transform.rotate(
                angle: _controller.value * 2.0 * math.pi,
                child: child,
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.08),
            Text(
              'Covid19\nTracker App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
