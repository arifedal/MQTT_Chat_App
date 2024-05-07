import 'package:chat_app/mqtt/MQTTManager.dart';
import 'package:chat_app/mqtt/states/MQTTAppStates.dart';
import 'package:chat_app/widgets/chat.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _hostTextController = TextEditingController();
  final TextEditingController _topicTextController = TextEditingController();

  MQTTManager? manager;
  String connectionStatus = ''; // Added connection status variable

  @override
  void dispose() {
    _hostTextController.dispose();
    _topicTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Color(0xFFCFE0F0),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(34),
                  bottomRight: Radius.circular(34),
                ),
                color: Color(0xFF2476EC),
              ),
              child: Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 110 + 70, // Adjusted top position to add space
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "PLEASE ENTER YOUR MQTT ADDRESS AND TOPIC NAME",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 70,
                ), // Added space between the text and text fields
                TextFormField(
                  controller: _hostTextController,
                  decoration: InputDecoration(
                    labelText: 'Broker Address',
                    labelStyle: TextStyle(
                      color: Color(0xFF2476EC),
                    ), // Adjust label color
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF2476EC),
                        width: 3,
                      ), // Adjust line thickness and color
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF2476EC),
                        width: 3,
                      ), // Adjust line thickness and color
                    ),
                  ),
                ),
                SizedBox(height: 40), // Added space between the text fields
                TextFormField(
                  controller: _topicTextController,
                  decoration: InputDecoration(
                    labelText: 'Topic Name',
                    labelStyle: TextStyle(
                      color: Color(0xFF2476EC),
                    ), // Adjust label color
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF2476EC),
                        width: 3,
                      ), // Adjust line thickness and color
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF2476EC),
                        width: 3,
                      ), // Adjust line thickness and color
                    ),
                  ),
                ),
                SizedBox(
                  height: 140,
                ), // Added space between the text field and the containers
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF2476EC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: _configureAndConnect,
                  child: Text(
                    'CONNECT',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20), // Added space between the containers
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFEC7824),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: _disconnect,
                  child: Text(
                    'DISCONNECT',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20), // Added space for connection status text
                Text(
                  connectionStatus,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _configureAndConnect() async {
    manager = MQTTManager(
      host: _hostTextController.text,
      topic: _topicTextController.text,
      state: Provider.of<MQTTAppState>(context, listen: false),
      message: '',
    );

    manager?.initializeMQTTClient();
    manager?.connect();

    // Update connection status message
    setState(() {
      connectionStatus = 'Connecting...';
    });

    // Check the connection state after a delay
    Future.delayed(Duration(seconds: 2), () {
      if (manager?.isConnected() ?? false) {
        setState(() {
          connectionStatus = 'Connected';
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatPage(manager: manager!)),
        );
      } else {
        setState(() {
          connectionStatus = 'Connection failed';
        });
      }
    });
  }

  void _disconnect() {
    manager?.disconnect();

    // Update connection status message
    setState(() {
      connectionStatus = 'Disconnected';
    });
  }
}
