import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';

class CircularProgressWithTimer extends StatelessWidget {
  final Color bgColor;
  final Color valueColor;
  final String time;
  final Color timeColor;
  final double? value;
  const CircularProgressWithTimer({
    super.key,
    this.bgColor = AppColors.white,
    this.valueColor = AppColors.green,
    this.time = '00:00',
    this.timeColor = AppColors.seaShell,
    this.value = .8,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 50.h,
          width: 50.h,
          child: CircularProgressIndicator(
            value: value,
            backgroundColor: bgColor,
            color: valueColor,
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              time,
              style: GoogleFonts.publicSans(
                color: timeColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
