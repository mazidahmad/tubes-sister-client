import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:train_dashboard/model/jadwal_kereta.dart';

class MqttModule {
  final String brokerHost =
      "9c9c43cc8b12425fbc8c9bca59aca94c.s2.eu.hivemq.cloud";
  final int port = 8883;
  final String username = "hivemq.webclient.1672476741794";
  final String password = "lXZU<;7PW5degA:y3j.8";

  static const scheduleTopic = "dt/dashboard/jadwal_kereta";

  late MqttServerClient client;

  MqttModule() {
    String clientId = "client-${Random().nextInt(100000)}";
    client = MqttServerClient.withPort(brokerHost, clientId, port);
  }

  StreamController<JadwalKereta> messages = StreamController<JadwalKereta>();

  Future<void> connect() async {
    client.autoReconnect = true;
    client.resubscribeOnAutoReconnect = true;
    client.secure = true;
    client.securityContext = SecurityContext.defaultContext;
    await client.connect(username, password);
    client.subscribe(scheduleTopic, MqttQos.atMostOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) async {
      if (c[0].topic == scheduleTopic) {
        var rawMessage = c[0].payload as MqttPublishMessage;
        var data = JadwalKereta.fromJson(
            String.fromCharCodes(rawMessage.payload.message));
        messages.add(data);
      }
    });
  }
}
