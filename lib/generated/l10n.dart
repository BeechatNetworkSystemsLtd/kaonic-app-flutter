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

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
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
