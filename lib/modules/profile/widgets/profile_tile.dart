import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/app_colors.dart';
import '../../../core/constants/constants.dart';
import '../../../custom_widgets/svg_icons.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback? onTap;
  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    this.iconColor = AppColors.seaShell,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 14.h),
        decoration: isSelected
            ? BoxDecoration(
                boxShadow: kDropShadow,
                borderRadius: BorderRadius.circular(30.r),
                color: AppColors.black,
              )
            : const BoxDecoration(color: Colors.transparent),
        child: Row(
          children: [
            SvgIcon(
              icon: icon,
              color: isSelected ? iconColor : AppColors.grey,
            ),
            SizedBox(width: 10.h),
            Text(
              title,
              style: isSelected
                  ? GoogleFonts.publicSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.seaShell,
                    )
                  : GoogleFonts.publicSans(
                      fontSize: 15.sp,
                      color: AppColors.black,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
