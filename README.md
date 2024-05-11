# MQTT_Chat_App

  # Introduction
  The MQTT Chat App is a simple application designed to facilitate communication between users using MQTT (Message Queuing Telemetry Transport) protocol. It allows users to connect to a MQTT broker,      enter a specific topic, and engage in real-time messaging with other users subscribed to the same     topic.

  # What is MQQTT?
  MQTT is a lightweight messaging protocol ideal for IoT (Internet of Things) applications and real-time communication scenarios. It operates on a publish/subscribe model, where clients (publishers) send messages to a central server (broker), and other clients (subscribers) receive those messages based on their subscriptions to specific topics.

  # Features
  - User-friendly interface with welcome page and login functionality.
  - Connect to a MQTT broker using provided broker address.
  - Enter custom username and password for authentication.
  - Create and select topic names for communication.
  - Real-time messaging between users subscribed to the same topic.

  # Installation

  1. Clone the repository:
      git clone https://github.com/your-username/mqtt-chat-app.git

  2. Navigate to the project directory:
      cd mqtt-chat-app

  # Usage
  1. Launch the application.
  2. On the welcome page, tap to proceed to the LOGIN page.
  3. Enter the required information:
        - Broker Address: Obtain a free broker address from HiveMQ or another provider.
        - Username and Password: Create a username and password for authentication.
        - Topic Name: Enter one of the topic names created in the broker address.
  4. If the information is correct, the connection is established, and you will be directed to the Chat page.
  5. From the Chat page, you can write and send messages and view messages from other users subscribed to the same topic.

  # Dependencies
  - MQTT Python: Python client library for MQTT protocol.
  - PyQt5: Utilized for creating the graphical user interface.

  # Acknowledgments
  - HiveMQ: Provider of MQTT broker services.
  - MQTT.org: Official website for MQTT protocol.

  # Screenshots
  ![welcomePage](https://github.com/arifedal/MQTT_Chat_App/assets/64319887/8f991174-716a-4402-a34d-81e819f4f703)
![chatPage](https://github.com/arifedal/MQTT_Chat_App/assets/64319887/831a20d5-244e-4223-870d-9f16988c97bb)
![loginPage](https://github.com/arifedal/MQTT_Chat_App/assets/64319887/c6452754-a9e9-4b54-803b-c8ce6ceb168d)
