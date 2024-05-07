//MQTTManager

import 'package:chat_app/mqtt/states/MQTTAppStates.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTManager {
  final MQTTAppState _currentState;
  MqttServerClient? _client;
  final String _host;
  final String _topic;
  late Function(String) _messageListener;

  MQTTManager({
    required String host,
    required String topic,
    required MQTTAppState state,
    required String message,
  })  : _host = host,
        _topic = topic,
        _currentState = state;

  void initializeMQTTClient() {
    _client = MqttServerClient(_host, '');
    _client?.port = 8883;
    _client?.useWebSocket = false;
    _client?.secure = true;
    _client?.logging(on: true);

    _client?.onConnected = onConnected;
    _client?.onSubscribed = onSubscribed;
    _client?.onDisconnected = onDisconnected;
    _client?.pongCallback = onConnected;
    _client?.onSubscribeFail = onSubscribeFail;
    _client?.onUnsubscribed = onUnsubscribed;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('Android')
        .authenticateAs('Username', 'Password')
        .startClean()
        .withWillTopic(_topic)
        .withWillMessage('')
        .withWillQos(MqttQos.exactlyOnce)
        .withWillRetain()
        .keepAliveFor(60);

    _client?.connectionMessage = connMessage;
  }

  void onMessage(String topic, MqttMessage message) {
    print('Received message: $topic, ${message}');
  }

  void onConnected() async {
    _currentState.setAppConnectionState(MQTTAppConnectionState.connected);
    print("Client connected..");
    _client?.subscribe('#', MqttQos.exactlyOnce);
    _client?.published;
    _client?.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final MqttPublishMessage recMess = c?[0].payload as MqttPublishMessage;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      _currentState.setReceivedText(pt);
      print("Topic is <${c?[0].topic}>, payload is <---$pt--->");
    });
    print("OnConnected client callback - Client connection was successful");
  }

  void onDisconnected() async {
    print("OnDisconnected client callback - Client disconnection");
    if (_client?.connectionStatus?.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      print("OnDisconnected callback is solicited, this is correct");
    }
    _currentState.setAppConnectionState((MQTTAppConnectionState.disconnected));
  }

  void onSubscribed(String topic) {
    print("Subscription confirmed for topic: $topic");
    //onConnected();
  }

  void startSubscriptions() {
    _client?.updates?.listen((dynamic c) {
      if (c is List<MqttReceivedMessage<MqttMessage>>) {
        final subscribeAckMessages =
            c.whereType<MqttSubscribeAckMessage>().toList();

        onSubscribed(subscribeAckMessages as String);
      }
    });
  }

  void connect() async {
    assert(_client != null);
    try {
      print('Start client connecting....');
      _currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
      await _client?.connect();
      if (_client?.connectionStatus?.state == MqttConnectionState.connected) {
        print('Client connected');
        _currentState.setAppConnectionState(MQTTAppConnectionState.connected);
        _client?.subscribe(_topic, MqttQos.exactlyOnce);
      } else {
        print('Client connection failed');
        _currentState
            .setAppConnectionState(MQTTAppConnectionState.disconnected);
      }
    } on Exception catch (e) {
      print('Client exception - $e');
      disconnect();
    }
  }

  void disconnect() {
    print('Disconnected');
    _client?.disconnect();
    _currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
  }

  void publish(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    _client?.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload!);
  }

  void subscribe(String topic) {
    _client?.subscribe(topic, MqttQos.exactlyOnce);
  }

  void startListeningForMessages(Function(String) listener,
      {bool excludeSent = false}) {
    _messageListener = listener;
    _client?.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      // Check if the message is sent and if exclusion is enabled
      if (!pt.startsWith("Sent:") || !excludeSent) {
        // Invoke the listener to handle the message
        _messageListener(pt);
      }
      print("Topic is <${c[0].topic}>, payload is <---$pt--->");
    });
  }

  void onSubscribeFail(String topic) {
    print('Failed to subscribe to topic: $topic');
  }

  void onUnsubscribed(String? topic) {
    if (topic != null) {
      print('Unsubscribed from topic: $topic');
    }
  }

  bool isConnected() {
    return _client?.connectionStatus?.state == MqttConnectionState.connected;
  }
}
