import 'package:kaonic/data/models/settings.dart';

extension MidxBitsExtension on MIDXSBits {
  String get description {
    switch (this) {
      case MIDXSBits.m0:
        return '0.375';
      case MIDXSBits.m1:
        return '0.5';
      case MIDXSBits.m2:
        return '0.75';
      case MIDXSBits.m3:
        return '1.0';
      case MIDXSBits.m4:
        return '1.25';
      case MIDXSBits.m5:
        return '1.5';
      case MIDXSBits.m6:
        return '1.75';
      case MIDXSBits.m7:
        return '2.0';
    }
  }

  int get value {
    switch (this) {
      case MIDXSBits.m0:
        return 0x0;
      case MIDXSBits.m1:
        return 0x1;
      case MIDXSBits.m2:
        return 0x2;
      case MIDXSBits.m3:
        return 0x3;
      case MIDXSBits.m4:
        return 0x4;
      case MIDXSBits.m5:
        return 0x5;
      case MIDXSBits.m6:
        return 0x6;
      case MIDXSBits.m7:
        return 0x7;
    }
  }
}
