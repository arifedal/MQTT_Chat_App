import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chat_app/widgets/loginMqtt.dart'; // Import the LoginPage

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<String> welcomeTexts = [
    'HOŞGELDİNİZ',
    'WELCOME',
    'WILLKOMMEN',
    'ДОБРО ПОЖАЛОВАТЬ',
    '欢迎'
  ];
  int currentTextIndex = 0;

  @override
  void initState() {
    super.initState();

    // Add a timer to switch between different welcome texts every second
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        currentTextIndex = (currentTextIndex + 1) % welcomeTexts.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCFE0F0), // Hex color for CFE0F0
      body: GestureDetector(
        onTap: () {
          // Navigate to LoginPage when user taps the screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: Text(
                  welcomeTexts[currentTextIndex],
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(
                'lib/icon/welcomeFoto.png', // Assuming your image is in assets/images folder
                width: 320, // Adjust width as needed
                height: 324, // Adjust height as needed
              ),
            ],
          ),
        ),
      ),
    );
  }
}
