import 'package:avinashgatekeeper/Config/Helper/HextoColor.dart';
import 'package:flutter/material.dart';

class AppColors{
  static Color TRANSPARENT = Colors.transparent;
  static Color WHITE = Colors.white;
  static Color BLACK = Colors.black;
  static Color DARK_GREY = Colors.grey.shade300;
  static Color SHADOW = Colors.black.withOpacity(0.1);
  static Color SHIMMER_BASE = Colors.grey[300]!;
  static Color SHIMMER_HIGHLIGHT = Colors.grey[100]!;
  static Color BARRIERCOLOR = Colors.black54;
  static Color YELLOW = Colors.yellow;
  static Color RED = HexColor("#C22727");
  static Color RED_LIGHT = HexColor("#ffa3ad");
  static Color RED_BOTTOM = Colors.red;
  static Color APP_THEME_COLOR = HexColor("#2f3f7b");
  static Color GREEN = HexColor("#25A92F");
  static Color ALERT_BUTTON_COLOR = HexColor("#f2f2f2");
  static Color  BACKGROUND_WHITE = const Color(0xffF5F6FA);
}



MaterialColor _factoryColor(int color) {
  return MaterialColor(color, <int, Color>{
    50: Color(color),
    100: Color(color),
    200: Color(color),
    300: Color(color),
    400: Color(color),
    500: Color(color),
    600: Color(color),
    700: Color(color),
    800: Color(color),
    900: Color(color),
  });



}
MaterialColor hex(String hex) => _factoryColor(_getColorHexFromStr(hex));


// ignore: non_constant_identifier_names
MaterialColor LIGHT_GREY = _factoryColor(0xffd8d8d8);
MaterialColor LIGHT_GREY_WITH_SHADE = _factoryColor(0xffd9d9d9);
 Color APP_FONT_COLOR = HexColor("#000000");
MaterialColor APP_GRAY_COLOR = hex("F8F8F8");
MaterialColor gray_color = hex("323232");
MaterialColor APP_THEME_COLOR = hex("266CB5");


int _getColorHexFromStr(String colorStr) {
  colorStr = "FF" + colorStr;
  colorStr = colorStr.replaceAll("#", "");
  int val = 0;
  int len = colorStr.length;
  for (int i = 0; i < len; i++) {
    int hexDigit = colorStr.codeUnitAt(i);
    if (hexDigit >= 48 && hexDigit <= 57) {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
// A..F
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
// a..f
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      val = 0xFFFFFFFF;
    }
  }
  return val;
}