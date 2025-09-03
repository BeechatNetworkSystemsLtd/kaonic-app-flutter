import 'package:flutter/material.dart';

final appThemeData = ThemeData(
    fontFamily: 'Sansation',
    scaffoldBackgroundColor: AppColors.black,
    textSelectionTheme: const TextSelectionThemeData());

abstract class AppColors {
  static const yellow = Color(0xFFF9C700);
  static const white = Colors.white;
  static const orange = Color(0xFFF97F00);
  static const red = Color(0xFFF93600);

  static const negative = Color(0xFFE91C21);
  static const positive = Color(0xFF4BBB54);

  static const black = Color(0xFF1D1D1B);
  static const grey1 = Color(0xFF343434);
  static const grey2 = Color(0xFF4D4D4D);
  static const grey3 = Color(0xFF8E8E8E);
  static const grey4 = Color(0xFF60605F);
  static const grey5 = Color(0xFFADADAD);

  static const bgGradient = LinearGradient(
    colors: [black, grey1],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const yellowGradient = LinearGradient(
    colors: [yellow, Color(0xFFF9A100)],
    stops: [0.5, 0.9],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
