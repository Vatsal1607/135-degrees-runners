import 'package:degrees_runners/core/app_colors.dart';
import 'package:degrees_runners/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OfflineWidget extends StatelessWidget {
  const OfflineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.amber,
      height: 1.sh / 1.8,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              height: 125.h,
              width: 125.h,
              ImageStrings.offline,
            ),
            Text(
              'YOU\'RE',
              style: GoogleFonts.publicSans(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColors.coralRed,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Text(
                'OFFLINE',
                style: GoogleFonts.publicSans(
                  fontSize: 30.sp,
                  color: AppColors.seaShell,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
