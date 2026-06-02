import 'package:flutter/material.dart';

const foregroundColor = Color(0xFF000000);
const backgroundColor = Color(0xFFFFFFFF);
const toDo = Color(0xFF00FF00);

Widget wrapApp(Widget child) {
  const textStyle = TextStyle(
    color: foregroundColor,
    backgroundColor: backgroundColor,
    locale: Locale('en', 'US'),
  );
  final data = ThemeData(
    textTheme: const TextTheme(
      displayLarge: textStyle,
      displayMedium: textStyle,
      displaySmall: textStyle,
      headlineLarge: textStyle,
      headlineMedium: textStyle,
      headlineSmall: textStyle,
      titleLarge: textStyle,
      titleMedium: textStyle,
      titleSmall: textStyle,
      bodyLarge: textStyle,
      bodyMedium: textStyle,
      bodySmall: textStyle,
      labelLarge: textStyle,
      labelMedium: textStyle,
      labelSmall: textStyle,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: backgroundColor,
      onPrimary: foregroundColor,
      secondary: toDo,
      onSecondary: toDo,
      surface: toDo,
      onSurface: toDo,
      error: toDo,
      onError: const Color(0xFFFF0000),
    ),
  );
  return Theme(
    data: data,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: <Widget>[
          Container(color: backgroundColor),
          padding(child),
        ],
      ),
    ),
  );
}

Padding padding(Widget child) =>
    Padding(padding: EdgeInsetsGeometry.all(5), child: child);

Container border(Widget child) => Container(
  decoration: BoxDecoration(
    border: BoxBorder.all(color: foregroundColor, width: 1.0),
  ),
  child: child,
);

final tableBorder = TableBorder.all(color: foregroundColor, width: 1.0);

Column column({required List<Widget> children}) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);

Widget button(String label, {required void Function() onPressed}) =>
    //RawMaterialButton(onPressed: onPressed, child: Text(label));
    TextButton(onPressed: onPressed, child: Text(label));
