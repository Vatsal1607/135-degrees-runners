import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/app_colors.dart';

class BottomBlurOnPage extends StatelessWidget {
  final bool isTopBlur;
  final double height;
  const BottomBlurOnPage({
    super.key,
    this.isTopBlur = false,
    this.height = 36,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: isTopBlur ? 0 : null,
      left: 0,
      right: 0,
      bottom: isTopBlur ? null : 0,
      height: height.h,
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: isTopBlur ? Alignment.topCenter : Alignment.bottomCenter,
              end: isTopBlur ? Alignment.bottomCenter : Alignment.topCenter,
              colors: [
                AppColors.seaShell, // Your background color
                // AppColors.seaShell.withOpacity(9),
                AppColors.seaShell.withOpacity(0), // Fades to transparent
              ],
            ),
          ),
        ),
      ),
    );
  }
}
