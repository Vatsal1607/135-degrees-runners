import 'package:degrees_runners/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:degrees_runners/custom_widgets/custom_button.dart';
import 'package:degrees_runners/modules/order_details/widgets/item_details_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';

class AcceptedOrderDetailsPage extends StatelessWidget {
  const AcceptedOrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarWithCenterTitle(
        title: 'Order Details',
        isAction: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ! TOP content
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                // * Table view data
                const ItemDetailsTable(),
              ],
            ),
            // ! Bottom content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deliver To,',
                    style: GoogleFonts.publicSans(
                      fontSize: 15.sp,
                      color: AppColors.black.withOpacity(.5),
                    ),
                  ),
                  Text(
                    'amtech design'.toUpperCase(),
                    style: GoogleFonts.publicSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Address:',
                    style: GoogleFonts.publicSans(
                      fontSize: 12.sp,
                      color: AppColors.black.withOpacity(.5),
                    ),
                  ),
                  Text(
                    'E-1102, 11th floor, e-block, titanium city center.',
                    style: GoogleFonts.publicSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    height: 48.h,
                    onTap: () {},
                    text: 'PICKUP',
                    textColor: AppColors.black,
                    bgColor: AppColors.seaShell,
                    isBorder: false,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
