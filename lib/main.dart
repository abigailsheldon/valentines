import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

class ConfettiScreen extends StatefulWidget{
  const ConfettiScreen({super.key});

  @override
  _ConfettiScreenState createState() => _ConfettiScreenState();

}

class _ConfettiScreenState extends State<ConfettiScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 10));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: 
          Text(
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
                  
                  Text(
                    "Happy Valentine's Day!",
                    style: TextStyle(fontSize:30, fontFamily: 'Candelabra'),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/images/image2.png',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 300,
                    ),
                ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection:  3.14 / 2,
              emissionFrequency: 0.05,
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