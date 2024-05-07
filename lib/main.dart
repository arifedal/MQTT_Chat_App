import 'package:chat_app/widgets/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/mqtt/states/MQTTAppStates.dart';

void main() => runApp(
      ChangeNotifierProvider<MQTTAppState>(
        create: (context) => MQTTAppState(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(), // Set WelcomePage as the initial page
    );
  }
}
