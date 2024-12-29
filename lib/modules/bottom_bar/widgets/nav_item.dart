import 'package:degrees_runners/core/app_colors.dart';
import 'package:degrees_runners/custom_widgets/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/strings.dart';

class NavItem extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  final String icon;
  final Color selectedColor;
  const NavItem({
    super.key,
    this.onTap,
    required this.label,
    this.icon = IconStrings.history,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: 120.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgIcon(
              icon: icon,
              color: selectedColor,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: GoogleFonts.publicSans(
                color: selectedColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
