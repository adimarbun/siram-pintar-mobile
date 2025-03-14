import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final String broker = 'sirampintar.site'; // Ganti dengan broker kamu
  final int port = 1883;
  final String clientId = '';
  late MqttServerClient client;


  MqttService() {
    client = MqttServerClient(broker, clientId);
    client.port = port;
    client.keepAlivePeriod = 60;
    client.onConnected = _onConnected;
    client.onDisconnected = _onDisconnected;
  }

  Future<void> connect() async {
    client.logging(on: true);
    client.secure = false;
    client.setProtocolV311(); // MQTT versi 3.1.1
    client.onConnected = _onConnected;
    client.onDisconnected = _onDisconnected;

    try {
      print('Connecting to MQTT broker...');
      await client.connect();
    } catch (e) {
      print('Connection failed: $e');
      client.disconnect();
    }
  }

  void _onConnected() {
    print('Connected to MQTT broker');
  }

  void _onDisconnected() {
    print('Disconnected from MQTT broker');
  }

  void subscribe(String topic) {
    client.subscribe(topic, MqttQos.atMostOnce);
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? messages) {
      final MqttPublishMessage message = messages![0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(message.payload.message);
      print('Received: $payload');
    });
  }

  void publish(String topic, String message) {
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
        final builder = MqttClientPayloadBuilder();
        builder.addString(message);
        client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
        print('Published: $message to topic: $topic');
    } else {
        print('Cannot publish, MQTT client is not connected');
    }
    }


  void disconnect() {
    client.disconnect();
  }
}
