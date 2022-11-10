//

import 'package:flutter/material.dart';

class Pallet {
  Pallet._();

  static const Color appBar = Color(0xFF0F6AC6);
  static const Color background = Color(0xFFE8E8E8);
  static MaterialColor get appBarSwatch => appBar.toMaterialColor();
  static const Color green = Color(0xFF10AAC7);
  static const Color yellow = Color(0xFFFDE74C);
  static const Color blue = Color(0xFF256EFF); // F5F6FC
  static const Color red = Color(0xFFFF495C);
  static const Color card = Color(0xFFF5F6FC);
}

extension _Material on Color {
  Map<int, Color> _toSwatch() => {
        50: withOpacity(0.1),
        100: withOpacity(0.2),
        200: withOpacity(0.3),
        300: withOpacity(0.4),
        400: withOpacity(0.5),
        500: withOpacity(0.6),
        600: withOpacity(0.7),
        700: withOpacity(0.8),
        800: withOpacity(0.9),
        900: this,
      };

  MaterialColor toMaterialColor() => MaterialColor(
        value,
        _toSwatch(),
      );

  // MaterialAccentColor toMaterialAccentColor() => MaterialAccentColor(
  //       value,
  //       _toSwatch(),
  //     );
}
