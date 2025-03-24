import 'package:flutter/material.dart';
import 'package:musify_app/core/theme/colors.dart';

class CustomTheme extends ThemeExtension<CustomTheme> {
  const CustomTheme({
    this.transparent,
    this.white,
    this.black,
    this.buttonStart,
    this.buttonEnd,
    this.textFieldFillColor,
    this.textColor,
    this.dialogBackgroundColor,
  });
  final Color? transparent;
  final Color? white;
  final Color? black;
  final Color? buttonStart;
  final Color? buttonEnd;
  final Color? textFieldFillColor;
  final Color? textColor;
  final Color? dialogBackgroundColor;

  @override
  ThemeExtension<CustomTheme> copyWith() {
    return CustomTheme(
      transparent: transparent,
      white: white,
      black: black,
      buttonStart: buttonStart,
      buttonEnd: buttonEnd,
      textFieldFillColor: textFieldFillColor,
      textColor: textColor,
      dialogBackgroundColor: dialogBackgroundColor,
    );
  }

  @override
  ThemeExtension<CustomTheme> lerp(
      ThemeExtension<CustomTheme>? other, double t) {
    if (other is! CustomTheme) {
      return this;
    }
    return CustomTheme(
      transparent: Color.lerp(transparent, other.transparent, t),
      white: Color.lerp(white, other.white, t),
      black: Color.lerp(black, other.black, t),
      buttonStart: Color.lerp(buttonStart, other.buttonStart, t),
      buttonEnd: Color.lerp(buttonEnd, other.buttonEnd, t),
      textFieldFillColor:
          Color.lerp(textFieldFillColor, other.textFieldFillColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      dialogBackgroundColor:
          Color.lerp(dialogBackgroundColor, other.dialogBackgroundColor, t),
    );
  }

  static const light = CustomTheme(
    transparent: Colors.transparent,
    white: Color(0xFFFFFFFF),
    black: Color(0xFF000000),
    buttonStart: Color(0XFFFF0080),
    buttonEnd: Color(0XFFFF5580),
    textFieldFillColor: Color.fromARGB(255, 217, 217, 217),
    textColor: Colors.black,
    dialogBackgroundColor: LightColors.scaffoldBackground,
  );

  static const dark = CustomTheme(
    transparent: Colors.transparent,
    white: Color(0xFFFFFFFF),
    black: Color(0xFF000000),
    buttonStart: Color(0XFFFF0080),
    buttonEnd: Color(0XFFFF5580),
    textFieldFillColor: Color(0XFF00224D),
    textColor: Colors.white,
    dialogBackgroundColor: DarkColors.scaffoldBackground,
  );
}
