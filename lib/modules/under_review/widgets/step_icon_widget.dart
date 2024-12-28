import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../custom_widgets/svg_icons.dart';

class StepIconWidget extends StatelessWidget {
  final String icon;
  final Color bgColor;
  const StepIconWidget({
    super.key,
    this.icon = IconStrings.done,
    this.bgColor = AppColors.lightGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      width: 32.w,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: SvgIcon(
        icon: icon,
      ),
    );
  }
}
