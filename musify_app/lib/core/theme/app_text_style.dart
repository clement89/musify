import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle kBaseTextStyle = GoogleFonts.poppins();

  static TextStyle kButtonTitle = kBaseTextStyle.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle kTitle = kBaseTextStyle.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle kSubTitle = kBaseTextStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
}
