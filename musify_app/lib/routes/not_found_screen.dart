import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:musify_app/core/extentions/buildcontect_extention.dart';

class NotFoundScreen extends StatelessWidget {
  final String route;

  const NotFoundScreen({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.pages_outlined,
                color: context.customTheme.textColor,
                size: 64.sp,
              ),
              SizedBox(height: 20.h),
              Text(
                "Oops! Page not found",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: context.customTheme.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Text(
                "The route '${route}' doesn't exist or was moved.",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: context.customTheme.textColor!.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              ElevatedButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Go Back"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.customTheme.textColor,
                  foregroundColor: context.customTheme.dialogBackgroundColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
