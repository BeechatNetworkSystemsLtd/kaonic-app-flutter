enum OFDMOptions {
  option1,
  option2,
  option3,
  option4,
}

enum OFDMRate {
  MCS_0,
  MCS_1,
  MCS_2,
  MCS_3,
  MCS_4,
  MCS_5,
  MCS_6,
}

enum FSKBandwidthTime {
  bt05,
  bt1,
  bt15,
  bt2,
}

enum MIDXS {
  m0,
  m1,
  m2,
  m3,
}

enum MIDXSBits {
  m0,
  m1,
  m2,
  m3,
  m4,
  m5,
  m6,
  m7,
}

enum FSKModulationOrder {
  fsk2,
  fsk4,
}

enum FSKSymbolRate {
  rate50kHz,
  rate100kHz,
  rate150kHz,
  rate200kHz,
  rate300kHz,
  rate400kHz,
}

enum PDTMMode {
  noRssi,
  withRssi,
}

enum RXOOption {
  db6,
  db12,
  db18,
  disabled,
}

enum RXPTOOption {
  disabled,
  enabled,
}

enum MSEOption {
  disabled,
  enabled,
}

enum FECSOption {
  nrnsc,
  rsc,
}

enum FECIEOption {
  disabled,
  enabled,
}

enum SFD32Option {
  two16bit,
  single32bit,
}

enum CSFD1Option {
  uncodedIeee,
  uncodedRaw,
  codedIeee,
  codedRaw,
}

enum CSFD0Option {
  uncodedIeee,
  uncodedRaw,
  codedIeee,
  codedRaw,
}

enum SFDOption {
  sfd0,
  sfd1,
}

enum DWOption {
  disabled,
  enabled,
}
