import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
                  "PLEASE ENTER YOUR MQTT ADDRESS AND TOPIC NAME FOR LOGIN",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height: 70), // Added space between the text and text fields
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'MQTT Address',
                    labelStyle: TextStyle(
                        color: Color(0xFF2476EC)), // Adjust label color
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF2476EC),
                          width: 3), // Adjust line thickness and color
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF2476EC),
                          width: 3), // Adjust line thickness and color
                    ),
                  ),
                ),
                SizedBox(height: 40), // Added space between the text fields
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Topic Name',
                    labelStyle: TextStyle(
                        color: Color(0xFF2476EC)), // Adjust label color
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF2476EC),
                          width: 3), // Adjust line thickness and color
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF2476EC),
                          width: 3), // Adjust line thickness and color
                    ),
                  ),
                ),
                SizedBox(
                    height:
                        140), // Added space between the text field and the containers
                Container(
                  width: 327,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Color(0xFF2476EC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                      child: Text(
                    "CONNECT",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
                ),
                SizedBox(height: 20), // Added space between the containers
                Container(
                  width: 327,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Color(0xFFEC7824),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                      child: Text(
                    "DISCONNECT",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
