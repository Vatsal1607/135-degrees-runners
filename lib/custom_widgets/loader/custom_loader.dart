import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final Color color;
  final Color? bgColor;
  final double strokeWidth;
  final double height;
  final double width;
  const CustomLoader({
    super.key,
    this.color = AppColors.black,
    this.bgColor,
    this.strokeWidth = 4.0,
    this.height = 25,
    this.width = 25,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color),
        backgroundColor: bgColor,
      ),
    );
  }
}
