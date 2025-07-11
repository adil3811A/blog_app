import 'package:blog_app/core/theme/AppPallete.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static  _border([Color color =  AppPallete.borderColor]) =>  OutlineInputBorder(
      borderSide: BorderSide(
          color:color,
        width: 3
      ),
      borderRadius: BorderRadius.circular(10)
  );
  static final appTheme = ThemeData.dark().copyWith(
    chipTheme: ChipThemeData(
      color: WidgetStatePropertyAll(AppPallete.backgroundColor),
      side: BorderSide.none
    ),
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.backgroundColor
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder:_border(AppPallete.gradient1)
    )
  );
}