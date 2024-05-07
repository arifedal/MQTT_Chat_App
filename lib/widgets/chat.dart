import 'package:flutter/material.dart';
import 'package:chat_app/mqtt/MQTTManager.dart';

class ChatPage extends StatefulWidget {
  final MQTTManager manager;

  const ChatPage({required this.manager});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  List<String> messages = [];
  ScrollController _scrollController =
      ScrollController(); // Add ScrollController

  @override
  void initState() {
    super.initState();
    widget.manager.startListeningForMessages(_receivedMessage);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose(); // Dispose ScrollController
    super.dispose();
  }

  void _disconnectMQTT() {
    widget.manager.disconnect(); // Disconnect MQTT
  }

  void _sendMessage() {
    final messaged = _messageController.text;
    if (messaged.isNotEmpty) {
      widget.manager.publish(messaged); // Publish the message
      setState(() {
        messages.add("Sent: $messaged"); // Mark the message as sent
      });
      _scrollToBottom(); // Scroll to bottom after adding a new message
      _messageController.clear();
    }
  }

  void _receivedMessage(String messager) {
    if (!messager.startsWith('Sent:')) {
      // Check if the message is not sent by the current user
      widget.manager.subscribe(messager);
      setState(() {
        messages.add("Received: $messager");
      });
      _scrollToBottom(); // Scroll to bottom after receiving a new message
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(34),
                bottomRight: Radius.circular(34),
              ),
              color: Color(0xFF2476EC),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.keyboard_return, color: Colors.white),
                  onPressed: () {
                    _disconnectMQTT();
                  },
                ),
                Text(
                  'CHAT',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.power_settings_new, color: Colors.white),
                  onPressed: () {
                    // Do something when return key is pressed
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                controller: _scrollController, // Attach ScrollController
                reverse: false,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isSentMessage = message.startsWith('Sent:');
                  final alignment = isSentMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft;
                  final backgroundColor =
                      isSentMessage ? Colors.blue : Colors.green;

                  return Align(
                    alignment: alignment,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isSentMessage ? message.substring(5) : message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message here...',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Icon(Icons.send),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
