import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musify_app/core/extentions/buildcontect_extention.dart';
import 'package:musify_app/core/theme/app_text_style.dart';
import 'package:tdk_bouncingwidget/tdk_bouncingwidget.dart';
import 'package:vibration/vibration.dart';

class BouncingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double elevation;
  final Color shadowColor;

  const BouncingButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.elevation = 6.0,
    this.shadowColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customTheme;
    return BouncingWidgetInOut(
      scaleFactor: 0.1,
      onPressed: () {
        Vibration.vibrate(duration: 300);
      },
      bouncingType: BouncingType.bounceInAndOut,
      child: Material(
        elevation: elevation,
        color: colors.transparent,
        shadowColor: shadowColor,
        borderRadius: BorderRadius.circular(30.sp),
        child: InkWell(
          borderRadius: BorderRadius.circular(30.sp),
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.sp),
              gradient: LinearGradient(
                colors: [
                  colors.buttonStart!,
                  colors.buttonEnd!
                ], // Specify your gradient colors here
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.all(15.sp),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.sp),
              child: Text(
                title,
                style: AppTextStyles.buttonTitle.copyWith(color: colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
