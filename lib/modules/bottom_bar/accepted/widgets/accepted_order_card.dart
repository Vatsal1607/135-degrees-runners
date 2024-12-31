import 'package:degrees_runners/custom_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../../../../custom_widgets/circular_progress_with_timer.dart';

class AcceptedOrderCardWidget extends StatelessWidget {
  const AcceptedOrderCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // * Card widget
        Container(
          margin: EdgeInsets.only(bottom: 20.h),
          decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'ORDER ID ',
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        color: AppColors.doveGrey,
                      ),
                    ),
                    Text(
                      '12345 ',
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.doveGrey,
                      ),
                    ),
                    Text(
                      'PICKED ON ',
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.seaShell,
                      ),
                    ),
                    Text(
                      '9:51 AM',
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        color: AppColors.seaShell,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                // * Items details
                Text(
                  '1 × MASALA TEA\n2 × HOT COFFEE\n& MORE',
                  style: GoogleFonts.publicSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.seaShell,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(
                      'DELIVERY: ',
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.seaShell,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'E-1102, AMTECH DESIGN, 11TH FLOOR, E-BLOCK, T',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.publicSans(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.seaShell,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                CustomButton(
                  height: 55.h,
                  onTap: () {},
                  bgColor: AppColors.green,
                  text: 'deliver',
                ),
              ],
            ),
          ),
        ),
        // * Timer indicator
        Positioned(
          top: 30.h,
          right: 20.w,
          child: const CircularProgressWithTimer(),
        ),
      ],
    );
  }
}
