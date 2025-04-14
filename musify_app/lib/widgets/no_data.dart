import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final double iconSize;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  const NoDataWidget({
    super.key,
    this.message = 'No data available',
    this.icon = Icons.music_note,
    this.iconSize = 64,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textStyle ??
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey.shade600,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
