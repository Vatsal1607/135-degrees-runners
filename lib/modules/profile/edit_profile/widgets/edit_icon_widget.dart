import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../custom_widgets/svg_icons.dart';

class EditIconWidget extends StatelessWidget {
  final double height;
  final double width;
  const EditIconWidget({
    super.key,
    this.height = 35,
    this.width = 35,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.w,
      decoration: const BoxDecoration(
        color: AppColors.black,
        shape: BoxShape.circle,
      ),
      child: const SvgIcon(
        icon: IconStrings.edit,
        color: AppColors.seaShell,
      ),
    );
  }
}
