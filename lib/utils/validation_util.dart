import 'package:kaonic/generated/l10n.dart';

abstract class ValidationUtil {
  static RegExp ipRegExp = RegExp(
    r'^((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)\.){3}'
    r'(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)$',
  );
  static String validateIpAddress(String ipAddress) {
    if (ipAddress.isEmpty) {
      return S.current.ipCannotBeEmpty;
    }
    if (!ipRegExp.hasMatch(ipAddress)) {
      return S.current.invalidIpAddress;
    }

    return '';
  }
}
