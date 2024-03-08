import 'package:flutter/material.dart';
export 'buttons.dart';

const sideMargins = EdgeInsets.symmetric(horizontal: 25);

final Map<String, Color> background = {
  'default': const Color(0xFF333333),
  '900': const Color(0xFF393939),
  '800': const Color(0xFF4B4B4B),
  '700': const Color(0xFF5E5E5E),
  '600': const Color(0xFF727272),
  '500': const Color(0xFF868686),
  '400': const Color(0xFF9B9B9B),
  '300': const Color(0xFFB0B0B0),
  '200': const Color(0xFFC6C6C6),
  '100': const Color(0xFFDDDDDD),
  '50': const Color(0xFFF3F3F3),
};

final Map<String, Color> deepPurple = {
  'default': const Color(0xFF31293F),
  '900': const Color(0xFF3C3646),
  '800': const Color(0xFF50485C),
  '700': const Color(0xFF635A72),
  '600': const Color(0xFF786E87),
  '500': const Color(0xFF8C829C),
  '400': const Color(0xFFA197AF),
  '300': const Color(0xFFB5ADC2),
  '200': const Color(0xFFCAC4D4),
  '100': const Color(0xFFDFD8E6),
  '50': const Color(0xFFF4F3F7),
};

final Map<String, Color> mediumPurple = {
  'default': const Color(0xFF796EA8),
  '900': const Color(0xFF3B3457),
  '800': const Color(0xFF4D4573),
  '700': const Color(0xFF61578C),
  '600': const Color(0xFF756AA4),
  '500': const Color(0xFF8A7EB9),
  '400': const Color(0xFF9F94CB),
  '300': const Color(0xFFB5AADA),
  '200': const Color(0xFFCAC1E7),
  '100': const Color(0xFFE0DAF1),
  '50': const Color(0xFFF5F2FB),
};

final Map<String, Color> lightPurple = {
  'default': const Color(0xFFA6A9C8),
  '900': const Color(0xFF36384A),
  '800': const Color(0xFF474A61),
  '700': const Color(0xFF595D77),
  '600': const Color(0xFF6D708D),
  '500': const Color(0xFF8184A2),
  '400': const Color(0xFF9799B5),
  '300': const Color(0xFFADAFC7),
  '200': const Color(0xFFC4C5D8),
  '100': const Color(0xFFDBDCE8),
  '50': const Color(0xFFF3F3F7),
};

final Map<String, Color> buttons = {
  'default': const Color(0xFF554D74),
  '900': const Color(0xFF3B364F),
  '800': const Color(0xFF4E4767),
  '700': const Color(0xFF61597F),
  '600': const Color(0xFF756C95),
  '500': const Color(0xFF8A81AA),
  '400': const Color(0xFF9F96BD),
  '300': const Color(0xFFB4ACCE),
  '200': const Color(0xFFCAC3DD),
  '100': const Color(0xFFDFDAEB),
  '50': const Color(0xFFF4F3F9),
};

final Map<String, Color> text = {
  'default': const Color(0xFFD3D9E9),
  '900': const Color(0xFF363942),
  '800': const Color(0xFF474B56),
  '700': const Color(0xFF595E6B),
  '600': const Color(0xFF6C7290),
  '500': const Color(0xFF818695),
  '400': const Color(0xFF969BA9),
  '300': const Color(0xFFACB0BC),
  '200': const Color(0xFFC3C6D0),
  '100': const Color(0xFFDBDDE3),
  '50': const Color(0xFFF3F3F6),
};

final Map<String, Color> other = {
  'error': const Color(0xFFFF6666),
  'appBar': const Color(0xFF111111),
  'icon': const Color(0xFFD3D9E9),
};

final Map<String, String> font = {
  'default': 'Proxima Nova',
  'header': 'Proxima Nova Black',
};

final elevatedButtonBorderRadius = BorderRadius.circular(50.0);
final cardBorderRadius = BorderRadius.circular(10.0);

final ThemeData defaultTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark().copyWith(
      background: background['default'],
      error: text['900'],
      errorContainer: other['error'],
    ),
    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: other['appBar'],
      foregroundColor: text['default'],
    ),
    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      alignment: Alignment.centerLeft,
      backgroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return buttons['400']!;
        }
        return buttons['200']!;
      }),
      foregroundColor: MaterialStateProperty.all(text['900']),
      minimumSize: MaterialStateProperty.all(const Size(150, 50)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: elevatedButtonBorderRadius,
        ),
      ),
      splashFactory: InkRipple.splashFactory,
    )),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: buttons['default'],
      focusColor: buttons['900'],
      foregroundColor: text['default'],
      hoverColor: buttons['900'],
      shape: const CircleBorder(),
      sizeConstraints: const BoxConstraints(
        maxHeight: 60,
        maxWidth: 60,
        minHeight: 60,
        minWidth: 60,
      ),
      splashColor: buttons['800'],
    ),
    // Card
    cardTheme: CardTheme(
      color: lightPurple['200'],
      shape: RoundedRectangleBorder(
        borderRadius: cardBorderRadius,
      ),
    ),
    // Divider
    dividerTheme: DividerThemeData(
      color: background['500'],
      space: 0,
      thickness: 1,
    ),
    // Dropdown
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(
        fontFamily: font['default'],
        fontSize: 20.0,
        color: text['default'],
      ),
    ),
    // Input
    inputDecorationTheme: InputDecorationTheme(
      activeIndicatorBorder: BorderSide(
        color: background['800']!,
      ),
      alignLabelWithHint: true,
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: other['error']!,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: background['800']!,
        ),
      ),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: lightPurple['default']!,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: other['error']!,
        ),
      ),
      helperStyle: TextStyle(
        color: text['default']!,
        fontFamily: font['default'],
      ),
      hintStyle: TextStyle(
        color: text['default']!,
        fontFamily: font['default'],
      ),
      labelStyle: TextStyle(
        color: background['800'],
        fontFamily: font['default'],
      ),
    ),
    // Text
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontFamily: font['default'],
        fontSize: 17.0,
        color: text['default'],
      ),
      bodyMedium: TextStyle(
        fontFamily: font['default'],
        fontSize: 17.0,
        color: text['900'],
      ),
      titleLarge: TextStyle(
        fontFamily: font['header'],
        fontSize: 50.0,
        color: text['default'],
      ),
      titleMedium: TextStyle(
        fontFamily: font['header'],
        fontSize: 50.0,
        color: mediumPurple['default'],
      ),
      titleSmall: TextStyle(
        fontFamily: font['default'],
        fontSize: 25.0,
        color: text['default'],
      ),
      displayMedium: TextStyle(
        fontFamily: font['default'],
        fontSize: 20.0,
        color: text['default'],
      ),
      displaySmall: TextStyle(
        fontFamily: font['default'],
        fontSize: 20.0,
        color: text['900'],
      ),
    ));
