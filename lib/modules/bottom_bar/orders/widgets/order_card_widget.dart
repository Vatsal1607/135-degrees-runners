import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../../../../custom_widgets/custom_button.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: AppColors.davyGrey.withOpacity(.34),
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
                  'RECEIVED ON ',
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  '9:51 AM',
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    color: AppColors.black,
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
                    color: AppColors.doveGrey,
                  ),
                ),
                Flexible(
                  child: Text(
                    'E-1102, AMTECH DESIGN, 11TH FLOOR, E-BLOCK, T',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.publicSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            CustomButton(
              height: 55.h,
              onTap: () {},
              bgColor: AppColors.black,
              text: 'ACCEPT',
            ),
          ],
        ),
      ),
    );
  }
}
