import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Candelabra',
      ),
      home: const ConfettiScreen(),
    );
  }
}

class ConfettiScreen extends StatefulWidget {
  const ConfettiScreen({super.key});

  @override
  _ConfettiScreenState createState() => _ConfettiScreenState();
}

class _ConfettiScreenState extends State<ConfettiScreen>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  Timer? _timer;
  int _timerSeconds = 10; // Countdown duration

  @override
  void initState() {
    super.initState();

    // Initialize confetti controller
    _confettiController = ConfettiController(duration: const Duration(seconds: 10));
    _confettiController.play();

    // Initialize animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start timer
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_timerSeconds == 0) {
          timer.cancel();
          _animationController.stop();
          _confettiController.stop(); // Stop confetti when timer ends
        } else {
          _timerSeconds--;
        }
      });
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Using Assets in Flutter',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Happy Valentine's Day!",
                  style: TextStyle(fontSize: 30, fontFamily: 'Candelabra'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Image.asset(
                      'assets/images/image2.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Timer: $_timerSeconds s',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 3.14 / 2,
              emissionFrequency: 0.09,
              numberOfParticles: 10,
              gravity: 0.2,
              colors: [Colors.pinkAccent],
              createParticlePath: _drawHeart,
            ),
          ),
        ],
      ),
    );
  }

  Path _drawHeart(Size size) {
    Path path = Path();
    path.moveTo(size.width / 2, size.height / 4);
    path.cubicTo(size.width * 3 / 4, 0, size.width, size.height / 2, size.width / 2, size.height);
    path.cubicTo(0, size.height / 2, size.width / 4, 0, size.width / 2, size.height / 4);
    return path;
  }
}
