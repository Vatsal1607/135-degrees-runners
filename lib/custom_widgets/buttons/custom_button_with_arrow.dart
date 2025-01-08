import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../core/constants/strings.dart';
import '../svg_icons.dart';

class CustomButtonWithArrow extends StatelessWidget {
  final VoidCallback onTap;
  final bool isMargin;
  final String? text;
  final Widget? prefixWidget;
  const CustomButtonWithArrow({
    super.key,
    required this.onTap,
    this.isMargin = true,
    this.text,
    this.prefixWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58.h,
        margin: isMargin ? EdgeInsets.symmetric(horizontal: 32.w) : null,
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.r),
          color: AppColors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (prefixWidget != null) prefixWidget!,
                Text(
                  text ?? '',
                  style: GoogleFonts.publicSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.seaShell,
                  ),
                ),
              ],
            ),
            Container(
              height: 30.h,
              width: 45.w,
              decoration: BoxDecoration(
                color: AppColors.seaShell,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: const SvgIcon(
                icon: IconStrings.arrowNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
