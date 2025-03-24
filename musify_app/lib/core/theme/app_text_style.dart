import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle kBaseTextStyle = GoogleFonts.poppins();

  static TextStyle buttonTitle = kBaseTextStyle.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle phoneNumberLogin = kBaseTextStyle.copyWith(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  static TextStyle loginScreenTitle = kBaseTextStyle.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle loginScreenSubTitle = kBaseTextStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
}
