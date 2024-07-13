import 'package:flutter/material.dart';
import 'package:swf/main_style/main_style.dart';
import 'package:swf/main_style/main_style_color.dart';

class MainThemeData extends MainStyle {

  ThemeData get mainStyle => ThemeData(
    iconTheme: iconTheme,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: MainStyleColor.THEME_PRIMARY_PALE_YELLOW,
    elevatedButtonTheme: elevatedButtonThemeData,
    appBarTheme: appBarTheme,
    textTheme: textTheme,
    textSelectionTheme: textSelectionThemeData,
    dividerTheme: dividerThemeData,
    inputDecorationTheme: inputDecorationTheme,
    colorScheme: ColorScheme.fromSeed(seedColor: MainStyleColor.THEME_PRIMARY_SKY_BLUE),
    useMaterial3: true,
  );
}