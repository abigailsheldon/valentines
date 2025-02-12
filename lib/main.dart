import 'package:flutter/material.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: 
          Text(
            'Using Assets in Flutter',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
            ),
          centerTitle: true,
        ),
        
        body: Center(
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
        ),
    );
  }
}