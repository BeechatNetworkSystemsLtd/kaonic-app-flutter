import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';

extension CommunicationTypeExtension on KaonicCommunicationType {
  String get title {
    switch (this) {
      case KaonicCommunicationType.tcp:
        return S.current.connectivityTypeTCP;
      case KaonicCommunicationType.kaonicClient:
        return S.current.connectivityTypeKaonic;
    }
  }
}
