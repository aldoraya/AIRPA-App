import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penyewaan_gedung_app/models/enum.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penyewaan_gedung_app/logic/controllers/theme_provider.dart';

class AppTheme {
  static bool get isLightMode {
    try {
      return Get.find<ThemeController>().isLightMode;
    } catch (e) {
      return true;
    }
  }

  // colors
  static Color get primaryColor {
    try {
      ColorType colortypedata = Get.find<ThemeController>().colorType;
      return getColor(colortypedata);
    } catch (e) {
      return getColor(ColorType.verdigris);
    }

  }

  static Color get scaffoldBackgroundColor =>
      isLightMode ? const Color(0xFFF7F7F7) : const Color(0xFF1A1A1A);

  static Color get redErrorColor =>
      isLightMode ? const Color(0xFFAC0000) : const Color(0xFFAC0000);

  static Color get backgroundColor =>
      isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF2C2C2C);

  static Color get primaryTextColor =>
      isLightMode ? const Color(0xFF262626) : const Color(0xFFFFFFFF);

  static Color get secondaryTextColor =>
      isLightMode ? const Color(0xFFADADAD) : const Color(0xFF6D6D6D);

  static Color get whiteColor => const Color(0xFFFFFFFF);
  static Color get backColor => const Color(0xFF262626);

  static Color get fontcolor =>
      isLightMode ? const Color(0xFF1A1A1A) : const Color(0xFFF7F7F7);

  static ThemeData get getThemeData =>
      isLightMode ? _buildLightTheme() : _buildDarkTheme();

  static Color get facebookColor =>
      isLightMode ? const Color(0xFF3C5799) : const Color(0xFF3C5799);

   static Color get twitterColor =>
      isLightMode ? const Color(0xFF05A9F0) : const Color(0xFF05A9F0);

    static Color get goldColor =>
      isLightMode ? const Color(0xFFD3AF37) : const Color(0xFFD3AF37);
  

  static TextTheme _buildTextTheme(TextTheme base) {
    FontFamilyType fontType = FontFamilyType.workSans;
      try {
        fontType = Get.find<ThemeController>().fontType;
    } catch (_) {}

    return base.copyWith(
      displayLarge: getTextStyle(fontType, base.displayLarge!), //f-size 96
      displayMedium: getTextStyle(fontType, base.displayMedium!), //f-size 60
      displaySmall: getTextStyle(fontType, base.displaySmall!), //f-size 48
      headlineMedium: getTextStyle(fontType, base.headlineMedium!), //f-size 34
      headlineSmall: getTextStyle(fontType, base.headlineSmall!), //f-size 24
      titleLarge: getTextStyle(
        fontType,
        base.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ), //f-size 20
      labelLarge: getTextStyle(fontType, base.labelLarge!), //f-size 14
      bodySmall: getTextStyle(fontType, base.bodySmall!), //f-size 12
      bodyLarge: getTextStyle(fontType, base.bodyLarge!), //f-size 16
      bodyMedium: getTextStyle(fontType, base.bodyMedium!), //f-size 14
      titleMedium: getTextStyle(
        fontType,
        base.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ), //f-size 16
      titleSmall: getTextStyle(fontType, base.titleSmall!), //f-size 14
      labelSmall: getTextStyle(fontType, base.labelSmall!), //f-size 10
    );
  }

// we also get some Light and Dark color variants
  static Color getColor(ColorType colordata) {
    switch (colordata) {
      case ColorType.verdigris:
        return isLightMode ? const Color(0xFFD3AF37) : const Color(0xFFD3AF37);
      case ColorType.malibu:
        return isLightMode ? const Color(0xFF5DCAEC) : const Color(0xFF5DCAEC);
      case ColorType.darkSkyBlue:
        return isLightMode ? const Color(0xFF458CEA) : const Color(0xFF458CEA);
      case ColorType.bilobaFlower:
        return isLightMode ? const Color(0xFFff5f5f) : const Color(0xFFff5f5f);
    }
  }

  static TextStyle getTextStyle(
      FontFamilyType fontFamilyType, TextStyle textStyle) {
    switch (fontFamilyType) {
      case FontFamilyType.montserrat:
        return GoogleFonts.montserrat(textStyle: textStyle);
      case FontFamilyType.workSans:
        return GoogleFonts.workSans(textStyle: textStyle);
      case FontFamilyType.varela:
        return GoogleFonts.varela(textStyle: textStyle);
      case FontFamilyType.satisfy:
        return GoogleFonts.satisfy(textStyle: textStyle);
      case FontFamilyType.dancingScript:
        return GoogleFonts.dancingScript(textStyle: textStyle);
      case FontFamilyType.kaushanScript:
        return GoogleFonts.kaushanScript(textStyle: textStyle);
      default:
        return GoogleFonts.roboto(textStyle: textStyle);
    }
  }

  static ThemeData _buildLightTheme() {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: primaryColor,
    );
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      backgroundColor: backgroundColor,
      canvasColor: scaffoldBackgroundColor,
      buttonTheme: _buttonThemeData(colorScheme),
      dialogTheme: _dialogTheme(),
      cardTheme: _cardTheme(),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData _buildDarkTheme() {
    final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
      primary: primaryColor,
      secondary: primaryColor,
    );
    final ThemeData base = ThemeData.dark();

    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      backgroundColor: backgroundColor,
      canvasColor: scaffoldBackgroundColor,
      buttonTheme: _buttonThemeData(colorScheme),
      dialogTheme: _dialogTheme(),
      cardTheme: _cardTheme(),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ButtonThemeData _buttonThemeData(ColorScheme colorScheme) {
    return ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    );
  }

  static DialogTheme _dialogTheme() {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0,
      backgroundColor: backgroundColor,
    );
  }

  static CardTheme _cardTheme() {
    return CardTheme(
      clipBehavior: Clip.antiAlias,
      color: backgroundColor,
      shadowColor: secondaryTextColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(0),
    );
  }

  static get mapCardDecoration => BoxDecoration(
        color: AppTheme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppTheme.getThemeData.dividerColor,
              offset: const Offset(4, 4),
              blurRadius: 8.0),
        ],
      );
  static get buttonDecoration => BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.getThemeData.dividerColor,
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      );
  static get searchBarDecoration => BoxDecoration(
        color: AppTheme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(38)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.getThemeData.dividerColor,
            blurRadius: 8,
            // offset: Offset(4, 4),
          ),
        ],
      );

  static get boxDecoration => BoxDecoration(
        color: AppTheme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.getThemeData.dividerColor,
            //   offset: Offset(2, 2),
            blurRadius: 8,
          ),
        ],
      );
}

enum ThemeModeType {
  system,
  dark,
  light,
}