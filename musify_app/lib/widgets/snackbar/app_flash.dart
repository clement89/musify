import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';

enum FlashType { success, error, warning, info }

class AppFlash {
  static void show({
    required BuildContext context,
    required String message,
    String? title,
    FlashType type = FlashType.info,
  }) {
    Color indicatorColor;
    IconData icon;

    switch (type) {
      case FlashType.success:
        indicatorColor = Colors.green;
        icon = Icons.check_circle_outline;
        break;
      case FlashType.error:
        indicatorColor = Colors.red;
        icon = Icons.error_outline;
        break;
      case FlashType.warning:
        indicatorColor = Colors.orange;
        icon = Icons.warning_amber_rounded;
        break;
      case FlashType.info:
      default:
        indicatorColor = Colors.blue;
        icon = Icons.info_outline;
        break;
    }

    context.showFlash<bool>(
      barrierDismissible: true,
      duration: const Duration(seconds: 3),
      builder: (context, controller) => FlashBar(
        controller: controller,
        // forwardAnimationCurve: Curves.easeInCirc,
        // reverseAnimationCurve: Curves.bounceIn,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(20)),
        //   side: BorderSide(),
        // ),
        position: FlashPosition.top,
        // margin: const EdgeInsets.all(32.0),
        // indicatorColor: indicatorColor,
        // icon: Icon(icon, color: indicatorColor),
        backgroundColor: Colors.cyan,
        title: title != null
            ? Text(title, style: const TextStyle(fontWeight: FontWeight.bold))
            : null,
        content: Text(message),
      ),
    );
  }
}
