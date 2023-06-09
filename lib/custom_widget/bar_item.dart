import 'package:flutter/material.dart';

import '../model/color_theme.dart';

class BarItem extends IconButton {
  BarItem(
      {super.key,
      required Icon icon,
      required VoidCallback onPressed,
      required bool selected})
      : super(
            icon: icon,
            onPressed: onPressed,
            color: selected ? ColorTheme().pointer() : ColorTheme().base());
}
