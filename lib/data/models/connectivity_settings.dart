import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';

@Entity()
class ConnectivitySettings {
  ConnectivitySettings({
    this.id = 0,
    this.port = '8080',
    this.ip = '192.168.10.1',
    this.connectivityType = 1,
  });
  @Id()
  int id;
  final String ip;
  final String port;
  @Property(type: PropertyType.int)
  int connectivityType;

  @Transient()
  KaonicCommunicationType get type =>
      KaonicCommunicationType.values.elementAt(connectivityType);

  ConnectivitySettings copyWith({
    final String? ip,
    final String? port,
    final int? connectivityType,
  }) {
    return ConnectivitySettings(
      ip: ip ?? this.ip,
      port: port ?? this.port,
      connectivityType: connectivityType ?? this.connectivityType,
    );
  }

  String toJson() {
    return jsonEncode({
      'ip': ip,
      'port': port,
      'connectivityType': connectivityType,
    });
  }
}
