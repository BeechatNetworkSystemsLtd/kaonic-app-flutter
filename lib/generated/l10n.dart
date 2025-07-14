// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Create username:`
  String get createUsername {
    return Intl.message(
      'Create username:',
      name: 'createUsername',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Create passcode`
  String get createPasscode {
    return Intl.message(
      'Create passcode',
      name: 'createPasscode',
      desc: '',
      args: [],
    );
  }

  /// `Repeat passcode`
  String get repeatPasscode {
    return Intl.message(
      'Repeat passcode',
      name: 'repeatPasscode',
      desc: '',
      args: [],
    );
  }

  /// `Enter passcode`
  String get enterPasscode {
    return Intl.message(
      'Enter passcode',
      name: 'enterPasscode',
      desc: '',
      args: [],
    );
  }

  /// `type...`
  String get hint {
    return Intl.message(
      'type...',
      name: 'hint',
      desc: '',
      args: [],
    );
  }

  /// `User with this username is already exist`
  String get userExistError {
    return Intl.message(
      'User with this username is already exist',
      name: 'userExistError',
      desc: '',
      args: [],
    );
  }

  /// `Passcode did not match`
  String get passcodeNotMatch {
    return Intl.message(
      'Passcode did not match',
      name: 'passcodeNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Invalid passcode`
  String get invalidPasscode {
    return Intl.message(
      'Invalid passcode',
      name: 'invalidPasscode',
      desc: '',
      args: [],
    );
  }

  /// `User does not exist or passcode is incorrect`
  String get loginFailure {
    return Intl.message(
      'User does not exist or passcode is incorrect',
      name: 'loginFailure',
      desc: '',
      args: [],
    );
  }

  /// `Hello to`
  String get labelHelloTo {
    return Intl.message(
      'Hello to',
      name: 'labelHelloTo',
      desc: '',
      args: [],
    );
  }

  /// `!`
  String get labelExclamationSign {
    return Intl.message(
      '!',
      name: 'labelExclamationSign',
      desc: '',
      args: [],
    );
  }

  /// `Please save this file to be able to back up your account later.`
  String get labelPleaseSaveThisFile {
    return Intl.message(
      'Please save this file to be able to back up your account later.',
      name: 'labelPleaseSaveThisFile',
      desc: '',
      args: [],
    );
  }

  /// `Address:`
  String get labelAddress {
    return Intl.message(
      'Address:',
      name: 'labelAddress',
      desc: '',
      args: [],
    );
  }

  /// `Username:`
  String get labelUsername {
    return Intl.message(
      'Username:',
      name: 'labelUsername',
      desc: '',
      args: [],
    );
  }

  /// `unknown`
  String get labelUnknown {
    return Intl.message(
      'unknown',
      name: 'labelUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get labelContinue {
    return Intl.message(
      'Continue',
      name: 'labelContinue',
      desc: '',
      args: [],
    );
  }

  /// `Identify`
  String get labelIdentify {
    return Intl.message(
      'Identify',
      name: 'labelIdentify',
      desc: '',
      args: [],
    );
  }

  /// `Contact List`
  String get labelContactList {
    return Intl.message(
      'Contact List',
      name: 'labelContactList',
      desc: '',
      args: [],
    );
  }

  /// `Users nearby`
  String get labelUsersNearby {
    return Intl.message(
      'Users nearby',
      name: 'labelUsersNearby',
      desc: '',
      args: [],
    );
  }

  /// `Add this user to Contact List?`
  String get labelAddThisUserToContactList {
    return Intl.message(
      'Add this user to Contact List?',
      name: 'labelAddThisUserToContactList',
      desc: '',
      args: [],
    );
  }

  /// `Remove this user from Contact List?`
  String get labelRemoveThisUserFromContactList {
    return Intl.message(
      'Remove this user from Contact List?',
      name: 'labelRemoveThisUserFromContactList',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get labelNo {
    return Intl.message(
      'No',
      name: 'labelNo',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get labelYes {
    return Intl.message(
      'Yes',
      name: 'labelYes',
      desc: '',
      args: [],
    );
  }

  /// `Can't find any users nearby`
  String get labelCantFindAnyUsersNearby {
    return Intl.message(
      'Can\'t find any users nearby',
      name: 'labelCantFindAnyUsersNearby',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get labelSend {
    return Intl.message(
      'Send',
      name: 'labelSend',
      desc: '',
      args: [],
    );
  }

  /// `Pick File`
  String get pickFile {
    return Intl.message(
      'Pick File',
      name: 'pickFile',
      desc: '',
      args: [],
    );
  }

  /// `Radio`
  String get radio {
    return Intl.message(
      'Radio',
      name: 'radio',
      desc: '',
      args: [],
    );
  }

  /// `Frequency`
  String get Frequency {
    return Intl.message(
      'Frequency',
      name: 'Frequency',
      desc: '',
      args: [],
    );
  }

  /// `Tx Power`
  String get txPower {
    return Intl.message(
      'Tx Power',
      name: 'txPower',
      desc: '',
      args: [],
    );
  }

  /// `Channel`
  String get Channel {
    return Intl.message(
      'Channel',
      name: 'Channel',
      desc: '',
      args: [],
    );
  }

  /// `Channel spacing`
  String get ChannelSpacing {
    return Intl.message(
      'Channel spacing',
      name: 'ChannelSpacing',
      desc: '',
      args: [],
    );
  }

  /// `Option`
  String get option {
    return Intl.message(
      'Option',
      name: 'option',
      desc: '',
      args: [],
    );
  }

  /// `MCS`
  String get mcs {
    return Intl.message(
      'MCS',
      name: 'mcs',
      desc: '',
      args: [],
    );
  }

  /// `Option 1`
  String get opt1 {
    return Intl.message(
      'Option 1',
      name: 'opt1',
      desc: '',
      args: [],
    );
  }

  /// `Option 2`
  String get opt2 {
    return Intl.message(
      'Option 2',
      name: 'opt2',
      desc: '',
      args: [],
    );
  }

  /// `Option 3`
  String get opt3 {
    return Intl.message(
      'Option 3',
      name: 'opt3',
      desc: '',
      args: [],
    );
  }

  /// `Option 4`
  String get opt4 {
    return Intl.message(
      'Option 4',
      name: 'opt4',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `OTA Update`
  String get otaUpdate {
    return Intl.message(
      'OTA Update',
      name: 'otaUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Local OTA package`
  String get localOTApackage {
    return Intl.message(
      'Local OTA package',
      name: 'localOTApackage',
      desc: '',
      args: [],
    );
  }

  /// `OTA version`
  String get otaVersion {
    return Intl.message(
      'OTA version',
      name: 'otaVersion',
      desc: '',
      args: [],
    );
  }

  /// `local`
  String get local {
    return Intl.message(
      'local',
      name: 'local',
      desc: '',
      args: [],
    );
  }

  /// `remote`
  String get remote {
    return Intl.message(
      'remote',
      name: 'remote',
      desc: '',
      args: [],
    );
  }

  /// `Upload OTA package`
  String get uploadOTApackage {
    return Intl.message(
      'Upload OTA package',
      name: 'uploadOTApackage',
      desc: '',
      args: [],
    );
  }

  /// `Device version`
  String get deviceVersion {
    return Intl.message(
      'Device version',
      name: 'deviceVersion',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message(
      'Upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `Software Update`
  String get softwareUpdate {
    return Intl.message(
      'Software Update',
      name: 'softwareUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Ongoing call`
  String get ongoingCall {
    return Intl.message(
      'Ongoing call',
      name: 'ongoingCall',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to end the call and exit the screen?`
  String get doYouWantToEndTheCall {
    return Intl.message(
      'Do you want to end the call and exit the screen?',
      name: 'doYouWantToEndTheCall',
      desc: '',
      args: [],
    );
  }

  /// `Radio Settings`
  String get radioSettings {
    return Intl.message(
      'Radio Settings',
      name: 'radioSettings',
      desc: '',
      args: [],
    );
  }

  /// `Connectivity Settings`
  String get connectivitySettings {
    return Intl.message(
      'Connectivity Settings',
      name: 'connectivitySettings',
      desc: '',
      args: [],
    );
  }

  /// `IP`
  String get ip {
    return Intl.message(
      'IP',
      name: 'ip',
      desc: '',
      args: [],
    );
  }

  /// `Port`
  String get port {
    return Intl.message(
      'Port',
      name: 'port',
      desc: '',
      args: [],
    );
  }

  /// `Connectivity Type`
  String get connectivityType {
    return Intl.message(
      'Connectivity Type',
      name: 'connectivityType',
      desc: '',
      args: [],
    );
  }

  /// `TCP Client`
  String get connectivityTypeTCP {
    return Intl.message(
      'TCP Client',
      name: 'connectivityTypeTCP',
      desc: '',
      args: [],
    );
  }

  /// `Kaonic Client`
  String get connectivityTypeKaonic {
    return Intl.message(
      'Kaonic Client',
      name: 'connectivityTypeKaonic',
      desc: '',
      args: [],
    );
  }

  /// `Bandwidth Time`
  String get bandwidthTime {
    return Intl.message(
      'Bandwidth Time',
      name: 'bandwidthTime',
      desc: '',
      args: [],
    );
  }

  /// `Modulation Index Scale`
  String get modulationIndexScale {
    return Intl.message(
      'Modulation Index Scale',
      name: 'modulationIndexScale',
      desc: '',
      args: [],
    );
  }

  /// `OFDM`
  String get ofdm {
    return Intl.message(
      'OFDM',
      name: 'ofdm',
      desc: '',
      args: [],
    );
  }

  /// `FSK`
  String get fsk {
    return Intl.message(
      'FSK',
      name: 'fsk',
      desc: '',
      args: [],
    );
  }

  /// `Modulation Index`
  String get modulationIndex {
    return Intl.message(
      'Modulation Index',
      name: 'modulationIndex',
      desc: '',
      args: [],
    );
  }

  /// `Modulation Order`
  String get modulationOrder {
    return Intl.message(
      'Modulation Order',
      name: 'modulationOrder',
      desc: '',
      args: [],
    );
  }

  /// `Symbol Rate`
  String get symbolRate {
    return Intl.message(
      'Symbol Rate',
      name: 'symbolRate',
      desc: '',
      args: [],
    );
  }

  /// `Preamble detection does not take RSSI values into account`
  String get noRssi {
    return Intl.message(
      'Preamble detection does not take RSSI values into account',
      name: 'noRssi',
      desc: '',
      args: [],
    );
  }

  /// `Preamble detection takes RSSI values into account.`
  String get withRssi {
    return Intl.message(
      'Preamble detection takes RSSI values into account.',
      name: 'withRssi',
      desc: '',
      args: [],
    );
  }

  /// `PDTM`
  String get pdtm {
    return Intl.message(
      'PDTM',
      name: 'pdtm',
      desc: '',
      args: [],
    );
  }

  /// `RXO`
  String get rxo {
    return Intl.message(
      'RXO',
      name: 'rxo',
      desc: '',
      args: [],
    );
  }

  /// `RXPTO`
  String get rxpto {
    return Intl.message(
      'RXPTO',
      name: 'rxpto',
      desc: '',
      args: [],
    );
  }

  /// `MSE`
  String get mse {
    return Intl.message(
      'MSE',
      name: 'mse',
      desc: '',
      args: [],
    );
  }

  /// `FECS`
  String get fecs {
    return Intl.message(
      'FECS',
      name: 'fecs',
      desc: '',
      args: [],
    );
  }

  /// `FECIE`
  String get fecie {
    return Intl.message(
      'FECIE',
      name: 'fecie',
      desc: '',
      args: [],
    );
  }

  /// `SFD32`
  String get sfd32 {
    return Intl.message(
      'SFD32',
      name: 'sfd32',
      desc: '',
      args: [],
    );
  }

  /// `CSFD1`
  String get csfd1 {
    return Intl.message(
      'CSFD1',
      name: 'csfd1',
      desc: '',
      args: [],
    );
  }

  /// `CSFD0`
  String get csfd0 {
    return Intl.message(
      'CSFD0',
      name: 'csfd0',
      desc: '',
      args: [],
    );
  }

  /// `SFD1`
  String get sfd1 {
    return Intl.message(
      'SFD1',
      name: 'sfd1',
      desc: '',
      args: [],
    );
  }

  /// `SFD0`
  String get sfd0 {
    return Intl.message(
      'SFD0',
      name: 'sfd0',
      desc: '',
      args: [],
    );
  }

  /// `SFD`
  String get sfd {
    return Intl.message(
      'SFD',
      name: 'sfd',
      desc: '',
      args: [],
    );
  }

  /// `DW`
  String get dw {
    return Intl.message(
      'DW',
      name: 'dw',
      desc: '',
      args: [],
    );
  }

  /// `Frequency Inversion`
  String get frequencyInversion {
    return Intl.message(
      'Frequency Inversion',
      name: 'frequencyInversion',
      desc: '',
      args: [],
    );
  }

  /// `Preamble Inversion`
  String get preambleInversion {
    return Intl.message(
      'Preamble Inversion',
      name: 'preambleInversion',
      desc: '',
      args: [],
    );
  }

  /// `SFTQ`
  String get sftq {
    return Intl.message(
      'SFTQ',
      name: 'sftq',
      desc: '',
      args: [],
    );
  }

  /// `RAWBIT`
  String get rawbit {
    return Intl.message(
      'RAWBIT',
      name: 'rawbit',
      desc: '',
      args: [],
    );
  }

  /// `PE`
  String get pe {
    return Intl.message(
      'PE',
      name: 'pe',
      desc: '',
      args: [],
    );
  }

  /// `EN`
  String get en {
    return Intl.message(
      'EN',
      name: 'en',
      desc: '',
      args: [],
    );
  }

  /// `Preemphasis {count}`
  String preemphasis(Object count) {
    return Intl.message(
      'Preemphasis $count',
      name: 'preemphasis',
      desc: '',
      args: [count],
    );
  }

  /// `Preamble Length`
  String get preambleLength {
    return Intl.message(
      'Preamble Length',
      name: 'preambleLength',
      desc: '',
      args: [],
    );
  }

  /// `SFD Detection Threshold`
  String get sdtd {
    return Intl.message(
      'SFD Detection Threshold',
      name: 'sdtd',
      desc: '',
      args: [],
    );
  }

  /// `Preamble Detection Threshold`
  String get pdt {
    return Intl.message(
      'Preamble Detection Threshold',
      name: 'pdt',
      desc: '',
      args: [],
    );
  }

  /// `Presets`
  String get presets {
    return Intl.message(
      'Presets',
      name: 'presets',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Ip cannot be empty.`
  String get ipCannotBeEmpty {
    return Intl.message(
      'Ip cannot be empty.',
      name: 'ipCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid ip address.`
  String get invalidIpAddress {
    return Intl.message(
      'Invalid ip address.',
      name: 'invalidIpAddress',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Type a message`
  String get typeAMessage {
    return Intl.message(
      'Type a message',
      name: 'typeAMessage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
