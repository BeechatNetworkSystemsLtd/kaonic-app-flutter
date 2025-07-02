import 'package:kaonic/data/models/settings.dart';
import 'package:kaonic/generated/l10n.dart';

extension FskBandwidthExtension on FSKBandwidthTime {
  String get description {
    switch (this) {
      case FSKBandwidthTime.bt05:
        return 'BT = 0.5';
      case FSKBandwidthTime.bt1:
        return 'BT = 1';
      case FSKBandwidthTime.bt15:
        return 'BT = 1.5';
      case FSKBandwidthTime.bt2:
        return 'BT = 2';
    }
  }

  int get value {
    switch (this) {
      case FSKBandwidthTime.bt05:
        return 0x0;
      case FSKBandwidthTime.bt1:
        return 0x1;
      case FSKBandwidthTime.bt15:
        return 0x2;
      case FSKBandwidthTime.bt2:
        return 0x3;
    }
  }
}

extension FSKModulationOrderExtension on FSKModulationOrder {
  String get description {
    switch (this) {
      case FSKModulationOrder.fsk2:
        return '2-FSK';
      case FSKModulationOrder.fsk4:
        return '4-FSK';
    }
  }

  int get value {
    switch (this) {
      case FSKModulationOrder.fsk2:
        return 0x0;
      case FSKModulationOrder.fsk4:
        return 0x1;
    }
  }
}

extension FSKSymbolRateExtension on FSKSymbolRate {
  String get description {
    switch (this) {
      case FSKSymbolRate.rate50kHz:
        return '50kHz';
      case FSKSymbolRate.rate100kHz:
        return '100kHz';
      case FSKSymbolRate.rate150kHz:
        return '150kHz';
      case FSKSymbolRate.rate200kHz:
        return '200kHz';
      case FSKSymbolRate.rate300kHz:
        return '300kHz';
      case FSKSymbolRate.rate400kHz:
        return '400kHz';
    }
  }

  int get value {
    switch (this) {
      case FSKSymbolRate.rate50kHz:
        return 0x0;
      case FSKSymbolRate.rate100kHz:
        return 0x1;
      case FSKSymbolRate.rate150kHz:
        return 0x2;
      case FSKSymbolRate.rate200kHz:
        return 0x3;
      case FSKSymbolRate.rate300kHz:
        return 0x4;
      case FSKSymbolRate.rate400kHz:
        return 0x5;
    }
  }
}

extension PDTMModeExtension on PDTMMode {
  String get description {
    switch (this) {
      case PDTMMode.noRssi:
        return S.current.noRssi;
      case PDTMMode.withRssi:
        return S.current.withRssi;
    }
  }

  int get value {
    switch (this) {
      case PDTMMode.noRssi:
        return 0x0;
      case PDTMMode.withRssi:
        return 0x1;
    }
  }
}

extension RXOOptionExtension on RXOOption {
  String get description {
    switch (this) {
      case RXOOption.db6:
        return 'Receiver restarted by > 6dB stronger frame';
      case RXOOption.db12:
        return 'Receiver restarted by > 12dB stronger frame';
      case RXOOption.db18:
        return 'Receiver restarted by > 18dB stronger frame';
      case RXOOption.disabled:
        return 'Receiver override disabled';
    }
  }

  int get value {
    switch (this) {
      case RXOOption.db6:
        return 0x0;
      case RXOOption.db12:
        return 0x1;
      case RXOOption.db18:
        return 0x2;
      case RXOOption.disabled:
        return 0x3;
    }
  }
}

extension RXPTOOptionExtension on RXPTOOption {
  String get description {
    switch (this) {
      case RXPTOOption.disabled:
        return 'Receiver preamble timeout disabled';
      case RXPTOOption.enabled:
        return 'Receiver preamble timeout enabled';
    }
  }

  int get value {
    switch (this) {
      case RXPTOOption.disabled:
        return 0x0;
      case RXPTOOption.enabled:
        return 0x1;
    }
  }
}

extension MSEOptionExtension on MSEOption {
  String get description {
    switch (this) {
      case MSEOption.disabled:
        return 'Mode Switch disabled';
      case MSEOption.enabled:
        return 'Mode Switch enabled';
    }
  }

  int get value {
    switch (this) {
      case MSEOption.disabled:
        return 0x0;
      case MSEOption.enabled:
        return 0x1;
    }
  }
}

extension FECSOptionExtension on FECSOption {
  String get description {
    switch (this) {
      case FECSOption.nrnsc:
        return 'NRNSC';
      case FECSOption.rsc:
        return 'RSC';
    }
  }

  int get value {
    switch (this) {
      case FECSOption.nrnsc:
        return 0x0;
      case FECSOption.rsc:
        return 0x1;
    }
  }
}

extension FECIEOptionExtension on FECIEOption {
  String get description {
    switch (this) {
      case FECIEOption.disabled:
        return 'Interleaving disabled';
      case FECIEOption.enabled:
        return 'Interleaving enabled';
    }
  }

  int get value {
    switch (this) {
      case FECIEOption.disabled:
        return 0x0;
      case FECIEOption.enabled:
        return 0x1;
    }
  }
}

extension SFD32OptionExtension on SFD32Option {
  String get description {
    switch (this) {
      case SFD32Option.two16bit:
        return 'Search for two 16-bit SFD';
      case SFD32Option.single32bit:
        return 'Search for a single 32-bit SFD';
    }
  }

  int get value {
    switch (this) {
      case SFD32Option.two16bit:
        return 0x0;
      case SFD32Option.single32bit:
        return 0x1;
    }
  }
}

extension CSFD1OptionExtension on CSFD1Option {
  String get description {
    switch (this) {
      case CSFD1Option.uncodedIeee:
        return 'Uncoded IEEE mode';
      case CSFD1Option.uncodedRaw:
        return 'Uncoded RAW mode';
      case CSFD1Option.codedIeee:
        return 'Coded IEEE mode';
      case CSFD1Option.codedRaw:
        return 'Coded RAW mode';
    }
  }

  int get value {
    switch (this) {
      case CSFD1Option.uncodedIeee:
        return 0x0;
      case CSFD1Option.uncodedRaw:
        return 0x1;
      case CSFD1Option.codedIeee:
        return 0x2;
      case CSFD1Option.codedRaw:
        return 0x3;
    }
  }
}

extension CSFD0OptionExtension on CSFD0Option {
  String get description {
    switch (this) {
      case CSFD0Option.uncodedIeee:
        return 'Uncoded IEEE mode';
      case CSFD0Option.uncodedRaw:
        return 'Uncoded RAW mode';
      case CSFD0Option.codedIeee:
        return 'Coded IEEE mode';
      case CSFD0Option.codedRaw:
        return 'Coded RAW mode';
    }
  }

  int get value {
    switch (this) {
      case CSFD0Option.uncodedIeee:
        return 0x0;
      case CSFD0Option.uncodedRaw:
        return 0x1;
      case CSFD0Option.codedIeee:
        return 0x2;
      case CSFD0Option.codedRaw:
        return 0x3;
    }
  }
}

extension SFDOptionExtension on SFDOption {
  String get description {
    switch (this) {
      case SFDOption.sfd0:
        return 'SFD0 is used';
      case SFDOption.sfd1:
        return 'SFD1 is used';
    }
  }

  int get value {
    switch (this) {
      case SFDOption.sfd0:
        return 0x0;
      case SFDOption.sfd1:
        return 0x1;
    }
  }
}

extension DWOptionExtension on DWOption {
  String get description {
    switch (this) {
      case DWOption.disabled:
        return 'PSDU data whitening disabled';
      case DWOption.enabled:
        return 'PSDU data whitening enabled';
    }
  }

  int get value {
    switch (this) {
      case DWOption.disabled:
        return 0x0;
      case DWOption.enabled:
        return 0x1;
    }
  }
}
