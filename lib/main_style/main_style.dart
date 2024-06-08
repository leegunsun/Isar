import 'package:flutter/material.dart';
import 'package:swf/main_style/main_style_color.dart';

class MainStyle extends MainStyleColor {

  static ThemeData get mainStyle => ThemeData(
    primaryColor: MainStyleColor.THEME_PRIMARY_IVORY,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          foregroundColor: MainStyleColor.THEME_PRIMARY_NAVY,
          backgroundColor: MainStyleColor.THEME_PRIMARY_IVORY
      )
    ),
    appBarTheme: AppBarTheme(
    // color: Colors.blue, // 앱바의 기본 색상
    backgroundColor: Colors.blue[700], // 앱바의 배경 색상
    foregroundColor: Colors.white, // 앱바의 전경색
    elevation: 4, // 앱바의 그림자 높이
    shadowColor: Colors.black, // 그림자 색상
    shape: RoundedRectangleBorder( // 앱바 모양
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(15),
      ),
    ),
    iconTheme: IconThemeData( // 아이콘 테마
      color: Colors.white,
      size: 24,
    ),
    actionsIconTheme: IconThemeData( // 액션 아이콘 테마
      color: Colors.white,
      size: 24,
    ),
    centerTitle: true, // 제목 중앙 정렬
    titleSpacing: 20, // 제목 간격
    toolbarHeight: 70, // 툴바 높이
    toolbarTextStyle: TextStyle( // 툴바 텍스트 스타일
      color: Colors.white,
      fontSize: 18,
    ),
    titleTextStyle: TextStyle( // 제목 텍스트 스타일
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ), // 시스템 오버레이 스타일
  ),
    textTheme: TextTheme(

    ),
    colorScheme: ColorScheme.fromSeed(seedColor: MainStyleColor.THEME_PRIMARY_NAVY),
    useMaterial3: true,
  );

}