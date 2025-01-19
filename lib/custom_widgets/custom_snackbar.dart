import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void customSnackBar({
  required BuildContext context,
  required String message,
  Color backgroundColor = Colors.black,
  Color textColor = Colors.white,
  IconData? icon,
  Duration duration = const Duration(seconds: 4),
}) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: backgroundColor,
    duration: duration,
    margin: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 100.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    ),
    content: Row(
      children: [
        if (icon != null) ...[
          Icon(icon, color: textColor),
          SizedBox(width: 8.w),
        ],
        Expanded(
          child: Text(
            message,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    ),
  );

  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(snackBar);
}
