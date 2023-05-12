import 'package:flutter/material.dart';

class ColorTheme {
  //Sans le Context
  bool isDarkMode() {
    final window = WidgetsBinding.instance.window;
    final mode = MediaQueryData.fromView(window).platformBrightness;
    return (mode == Brightness.dark);
  }

  //Avec le Context
  bool isDarkModeWithContext(BuildContext context) {
    final mode = MediaQuery.of(context).platformBrightness;
    return (mode == Brightness.dark);
  }

  //Color pointer() => Colors.deepOrange;
  Color pointer() => Colors.amber.shade800;
  Color base() =>
      (isDarkMode()) ? const Color.fromRGBO(33, 33, 33, 1) : Colors.white;
  Color accent() => (isDarkMode()) ? Colors.grey : Colors.blue;
  Color textColor() => (isDarkMode()) ? Colors.white : Colors.black;
}
