import 'package:kaonic/data/models/settings.dart';

extension MidsxExtension on MIDXS {
  String get description {
    switch (this) {
      case MIDXS.m0:
        return 's = 1.0 - 1/8';
      case MIDXS.m1:
        return 's = 1.0';
      case MIDXS.m2:
        return 's = 1.0 + 1/8';
      case MIDXS.m3:
        return 's = 1.0 + 1/4';
    }
  }

  int get value {
    switch (this) {
      case MIDXS.m0:
        return 0x0;
      case MIDXS.m1:
        return 0x1;
      case MIDXS.m2:
        return 0x2;
      case MIDXS.m3:
        return 0x3;
    }
  }
}
